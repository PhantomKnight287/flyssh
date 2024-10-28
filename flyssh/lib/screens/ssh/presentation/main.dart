import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/models/theme.dart';
import 'package:flyssh/screens/ssh/presentation/virtual_keyboard.dart';
import 'package:flyssh/screens/ssh/service/main.dart';
import 'package:flyssh/utils/device.dart';
import 'package:window_size/window_size.dart';
import 'package:xterm/xterm.dart';
import 'package:gap/gap.dart';

class SshScreen extends StatefulWidget {
  const SshScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<SshScreen> createState() => SshScreenState();
}

class SshScreenState extends State<SshScreen> {
  late final terminal = Terminal(inputHandler: keyboard);
  late final keyboard = VirtualKeyboard(
    defaultInputHandler,
  );
  SSHSession? session;
  bool isLoading = true;
  String? error;
  String? title = "FlySSH";
  CustomTerminalTheme theme = CustomTerminalTheme.from(TerminalThemes.defaultTheme, name: "Default");
  late SSHClient client;
  @override
  void initState() {
    super.initState();
    initConnection();
  }

  Future<void> initConnection() async {
    try {
      final host = await HostService.getHostInfo(
        widget.id,
      );
      client = SSHClient(
        await SSHSocket.connect(
          host.hostname,
          host.port.toInt(),
        ),
        username: host.username,
        onPasswordRequest: () {
          return host.password?.replaceAll(String.fromCharCode(8), '').replaceAll(String.fromCharCode(2), '').trim();
        },
        identities: host.key != null
            ? SSHKeyPair.fromPem(
                host.key!.value.replaceAll(String.fromCharCode(8), '').replaceAll(String.fromCharCode(2), '').trim(),
                host.key!.passphrase?.replaceAll(String.fromCharCode(8), '').replaceAll(String.fromCharCode(2), '').trim(),
              )
            : [],
      );

      session = await client.shell(
        pty: SSHPtyConfig(
          width: terminal.viewHeight,
          height: terminal.viewHeight,
        ),
      );

      terminal.onResize = (width, height, pixelWidth, pixelHeight) {
        session!.resizeTerminal(width, height, pixelWidth, pixelHeight);
      };

      terminal.onOutput = (data) {
        session!.write(utf8.encode(data));
      };

      session!.stdout.cast<List<int>>().transform(const Utf8Decoder()).listen(terminal.write);
      session!.stderr.cast<List<int>>().transform(const Utf8Decoder()).listen(terminal.write);

      terminal.buffer.clear();
      terminal.buffer.setCursor(0, 0);

      terminal.onTitleChange = (title) async {
        if (isDesktop()) {
          setWindowTitle(title);
        } else {
          setState(() {
            this.title = title;
          });
        }
      };

      // Handle session completion separately
      session!.done.then((_) {
        // Handle session completion if needed
        if (mounted) {
          Navigator.of(context).pop();
        }
      }).catchError((e) {
        if (mounted) {
          setState(() {
            error = e.toString();
          });
        }
      });

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = e.toString();
          isLoading = false;
        });
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    session?.close();
    if (isDesktop()) {
      setWindowTitle("flyssh");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isPhone()
          ? AppBar(
              title: title != null
                  ? Text(
                      title!,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                    )
                  : null,
            )
          : null,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (error != null) {
      return Column(
        children: [
          if (!isPhone())
            Builder(
              builder: (context) {
                return Column(
                  children: [
                    const Gap(
                      BASE_SPACE * 4,
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: "Back",
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                          ),
                          style: const ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(
                              Size(
                                0,
                                0,
                              ),
                            ),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.zero,
                            ),
                          ),
                        ),
                        const Gap(
                          BASE_SPACE * 2,
                        ),
                      ],
                    ),
                    const Gap(
                      BASE_SPACE * 4,
                    ),
                  ],
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: Center(
              child: Text(
                error!,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Expanded(
          child: TerminalView(
            terminal,
            cursorType: TerminalCursorType.block,
            theme: theme,
          ),
        ),
        if (!isDesktop())
          VirtualKeyboardView(
            keyboard,
            session!,
          ),
      ],
    );
  }
}
