import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

class VirtualKeyboardView extends StatelessWidget {
  const VirtualKeyboardView(this.keyboard, this.session, {super.key});

  final SSHSession session;

  final VirtualKeyboard keyboard;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: keyboard,
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ToggleButtons(
                isSelected: [
                  keyboard.ctrl,
                  keyboard.alt,
                  keyboard.shift,
                ],
                onPressed: (index) {
                  switch (index) {
                    case 0:
                      keyboard.ctrl = !keyboard.ctrl;
                      break;
                    case 1:
                      keyboard.alt = !keyboard.alt;
                      break;
                    case 2:
                      keyboard.shift = !keyboard.shift;
                      break;
                    default:
                      break;
                  }
                },
                children: [
                  Text('Ctrl'),
                  Text('Alt'),
                  Text('Shift'),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        session.write(Uint8List.fromList('\x1b'.codeUnits));
                      },
                      child: Text("ESC")),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_upward,
                    ),
                    onPressed: () {
                      session.write(Uint8List.fromList('\x1b[A'.codeUnits));
                    },
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      onPressed: () {
                        session.write(Uint8List.fromList('\x1b[B'.codeUnits));
                      }),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      session.write(Uint8List.fromList('\x1b[D'.codeUnits));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      session.write(Uint8List.fromList('\x1b[C'.codeUnits));
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class VirtualKeyboard extends TerminalInputHandler with ChangeNotifier {
  final TerminalInputHandler _inputHandler;

  VirtualKeyboard(
    this._inputHandler,
  );
  bool _esc = false;

  bool get esc => _esc;

  set esc(bool value) {
    if (_esc != value) {
      _esc = value;
      notifyListeners();
    }
  }

  bool _ctrl = false;

  bool get ctrl => _ctrl;

  set ctrl(bool value) {
    if (_ctrl != value) {
      _ctrl = value;
      notifyListeners();
    }
  }

  bool _shift = false;

  bool get shift => _shift;

  set shift(bool value) {
    if (_shift != value) {
      _shift = value;
      notifyListeners();
    }
  }

  bool _alt = false;

  bool get alt => _alt;

  set alt(bool value) {
    if (_alt != value) {
      _alt = value;
      notifyListeners();
    }
  }

  void sendArrow(TerminalKey key, Terminal terminal) {
    final event = TerminalKeyboardEvent(
      key: key,
      ctrl: _ctrl,
      alt: _alt,
      shift: _shift,
      altBuffer: terminal.isUsingAltBuffer,
      platform: terminal.platform,
      state: terminal,
    );
    final sequence = _inputHandler.call(event);
    if (sequence != null) {
      terminal.write('\u001b[B');
    }
  }

  @override
  String? call(TerminalKeyboardEvent event) {
    return _inputHandler.call(event.copyWith(
      ctrl: event.ctrl || _ctrl,
      shift: event.shift || _shift,
      alt: event.alt || _alt,
    ));
  }
}
