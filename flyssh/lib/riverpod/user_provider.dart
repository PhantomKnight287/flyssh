import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String username;
  final String masterKey;
  User({
    required this.name,
    required this.username,
    required this.masterKey,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  toJson() => _$UserToJson(this);
}

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    return null;
  }

  Future<void> login(String username, String name, String masterKey) async {
    state = User(
      name: name,
      username: username,
      masterKey: masterKey,
    );
  }

  Future<void> logout() async {
    state = null;
  }
}
