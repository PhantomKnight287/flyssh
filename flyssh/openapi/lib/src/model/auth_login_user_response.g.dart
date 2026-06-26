// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_user_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthLoginUserResponseCWProxy {
  AuthLoginUserResponse expiresAt(int? expiresAt);

  AuthLoginUserResponse name(String? name);

  AuthLoginUserResponse token(String? token);

  AuthLoginUserResponse username(String? username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthLoginUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthLoginUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthLoginUserResponse call({
    int? expiresAt,
    String? name,
    String? token,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthLoginUserResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthLoginUserResponse.copyWith.fieldName(...)`
class _$AuthLoginUserResponseCWProxyImpl
    implements _$AuthLoginUserResponseCWProxy {
  const _$AuthLoginUserResponseCWProxyImpl(this._value);

  final AuthLoginUserResponse _value;

  @override
  AuthLoginUserResponse expiresAt(int? expiresAt) => this(expiresAt: expiresAt);

  @override
  AuthLoginUserResponse name(String? name) => this(name: name);

  @override
  AuthLoginUserResponse token(String? token) => this(token: token);

  @override
  AuthLoginUserResponse username(String? username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthLoginUserResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthLoginUserResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthLoginUserResponse call({
    Object? expiresAt = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return AuthLoginUserResponse(
      expiresAt: expiresAt == const $CopyWithPlaceholder()
          ? _value.expiresAt
          // ignore: cast_nullable_to_non_nullable
          : expiresAt as int?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
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

extension $AuthLoginUserResponseCopyWith on AuthLoginUserResponse {
  /// Returns a callable class that can be used as follows: `instanceOfAuthLoginUserResponse.copyWith(...)` or like so:`instanceOfAuthLoginUserResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthLoginUserResponseCWProxy get copyWith =>
      _$AuthLoginUserResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginUserResponse _$AuthLoginUserResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthLoginUserResponse', json, ($checkedConvert) {
  final val = AuthLoginUserResponse(
    expiresAt: $checkedConvert('expiresAt', (v) => (v as num?)?.toInt()),
    name: $checkedConvert('name', (v) => v as String?),
    token: $checkedConvert('token', (v) => v as String?),
    username: $checkedConvert('username', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$AuthLoginUserResponseToJson(
  AuthLoginUserResponse instance,
) => <String, dynamic>{
  'expiresAt': ?instance.expiresAt,
  'name': ?instance.name,
  'token': ?instance.token,
  'username': ?instance.username,
};
