class SshKey {
  String label;
  String? value;
  String? passphrase;
  int id;

  SshKey({
    required this.id,
    required this.label,
    this.value,
    this.passphrase,
  });
}
