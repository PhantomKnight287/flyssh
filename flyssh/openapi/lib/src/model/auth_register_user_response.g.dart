// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_user_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthRegisterUserResponseCWProxy {
  AuthRegisterUserResponse expiresAt(int? expiresAt);

  AuthRegisterUserResponse name(String? name);

  AuthRegisterUserResponse recoveryKey(String? recoveryKey);

  AuthRegisterUserResponse token(String? token);

  AuthRegisterUserResponse username(String? username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRegisterUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRegisterUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRegisterUserResponse call({
    int? expiresAt,
    String? name,
    String? recoveryKey,
    String? token,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthRegisterUserResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthRegisterUserResponse.copyWith.fieldName(...)`
class _$AuthRegisterUserResponseCWProxyImpl
    implements _$AuthRegisterUserResponseCWProxy {
  const _$AuthRegisterUserResponseCWProxyImpl(this._value);

  final AuthRegisterUserResponse _value;

  @override
  AuthRegisterUserResponse expiresAt(int? expiresAt) =>
      this(expiresAt: expiresAt);

  @override
  AuthRegisterUserResponse name(String? name) => this(name: name);

  @override
  AuthRegisterUserResponse recoveryKey(String? recoveryKey) =>
      this(recoveryKey: recoveryKey);

  @override
  AuthRegisterUserResponse token(String? token) => this(token: token);

  @override
  AuthRegisterUserResponse username(String? username) =>
      this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRegisterUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRegisterUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRegisterUserResponse call({
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? recoveryKey = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return AuthRegisterUserResponse(
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      recoveryKey: recoveryKey == const $CopyWithPlaceholder()
          ? _value.recoveryKey
          // ignore: cast_nullable_to_non_nullable
          : recoveryKey as String?,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String?,
    );
  }
}

extension $AuthRegisterUserResponseCopyWith on AuthRegisterUserResponse {
  /// Returns a callable class that can be used as follows: `instanceOfAuthRegisterUserResponse.copyWith(...)` or like so:`instanceOfAuthRegisterUserResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthRegisterUserResponseCWProxy get copyWith =>
      _$AuthRegisterUserResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRegisterUserResponse _$AuthRegisterUserResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthRegisterUserResponse', json, ($checkedConvert) {
  final val = AuthRegisterUserResponse(
    expiresAt: $checkedConvert('expiresAt', (v) => (v as num?)?.toInt()),
    name: $checkedConvert('name', (v) => v as String?),
    recoveryKey: $checkedConvert('recoveryKey', (v) => v as String?),
    token: $checkedConvert('token', (v) => v as String?),
    username: $checkedConvert('username', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AuthRegisterUserResponseToJson(
  AuthRegisterUserResponse instance,
) => <String, dynamic>{
  'expiresAt': ?instance.expiresAt,
  'name': ?instance.name,
  'recoveryKey': ?instance.recoveryKey,
  'token': ?instance.token,
  'username': ?instance.username,
};
