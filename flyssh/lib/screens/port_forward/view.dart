import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/models/port_forward.dart';
import 'package:flyssh/screens/port_forward/widgets/add_forward_dialog.dart';
import 'package:flyssh/screens/port_forward/widgets/forward_card.dart';
import 'package:flyssh/services/ssh.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:toastification/toastification.dart';

class PortForwardView extends StatefulWidget {
  final String sessionId;

  const PortForwardView({super.key, required this.sessionId});

  @override
  State<PortForwardView> createState() => _PortForwardViewState();
}

class _PortForwardViewState extends State<PortForwardView> {
  final SshSessionManager _sessionManager = getIt<SshSessionManager>();

  @override
  void initState() {
    super.initState();
    _sessionManager.addListener(_onChanged);
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _sessionManager.removeListener(_onChanged);
    super.dispose();
  }

  Future<void> _addForward() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => const AddForwardDialog(),
    );
    if (result == null) return;

    final type = result['type'] as PortForwardType;
    final bindPort = result['bindPort'] as int;
    final targetHost = result['targetHost'] as String;
    final targetPort = result['targetPort'] as int;

    try {
      if (type == PortForwardType.local) {
        await _sessionManager.addLocalForward(
          sessionId: widget.sessionId,
          localPort: bindPort,
          remoteHost: targetHost,
          remotePort: targetPort,
        );
      } else {
        await _sessionManager.addRemoteForward(
          sessionId: widget.sessionId,
          remotePort: bindPort,
          localHost: targetHost,
          localPort: targetPort,
        );
      }
      if (mounted) {
        toastification.show(
          title: const Text('Port forward started'),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          title: Text('Failed: ${e.toString()}'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = _sessionManager.sessions[widget.sessionId];
    if (session == null) {
      return PageScaffold(
        title: "Port Forwarding",
        showBackButton: true,
        body: const Center(child: Text('Session not found')),
      );
    }

    final forwards = session.portForwards;

    return PageScaffold(
      title: "Port Forwarding",
      showBackButton: true,
      floatingActionButton: FloatingActionButton(
        onPressed: _addForward,
        child: const Icon(Icons.add),
      ),
      body: forwards.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_horiz,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  SizedBox(height: BASE_SPACE * 4),
                  Text(
                    'No port forwards',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: BASE_SPACE * 2),
                  Text(
                    'Tap + to create a tunnel',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(BASE_SPACE * 3),
              itemCount: forwards.length,
              itemBuilder: (context, index) {
                final forward = forwards[index];
                return ForwardCard(
                  forward: forward,
                  onDelete: () => _sessionManager.removeForward(
                    widget.sessionId,
                    forward.id,
                  ),
                );
              },
            ),
    );
  }
}
