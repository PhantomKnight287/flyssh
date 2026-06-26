import 'dart:async';
import 'dart:io';

import 'package:dartssh2/dartssh2.dart';

enum PortForwardType { local, remote }

enum PortForwardStatus { active, stopped, error }

class PortForward {
  final String id;
  final PortForwardType type;
  final String bindHost;
  final int bindPort;
  final String targetHost;
  final int targetPort;
  PortForwardStatus status;
  String? errorMessage;

  // Cleanup references
  ServerSocket? serverSocket; // local forward listener
  SSHRemoteForward? remoteForward; // remote forward handle
  final List<StreamSubscription> subscriptions = [];

  PortForward({
    required this.id,
    required this.type,
    required this.bindHost,
    required this.bindPort,
    required this.targetHost,
    required this.targetPort,
    this.status = PortForwardStatus.active,
    this.errorMessage,
  });

  String get displayBind => '$bindHost:$bindPort';
  String get displayTarget => '$targetHost:$targetPort';

  Future<void> close() async {
    for (final sub in subscriptions) {
      await sub.cancel();
    }
    subscriptions.clear();
    serverSocket?.close();
    remoteForward?.close();
    status = PortForwardStatus.stopped;
  }
}
