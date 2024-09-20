import 'package:flyssh/models/key.dart';

class Host {
  String? label;
  String hostname;
  String username;
  String? password;
  int id;
  SshKey? sshKey;
  Host({
    this.label,
    required this.hostname,
    required this.username,
    required this.id,
    this.password,
    this.sshKey,
  });
}
