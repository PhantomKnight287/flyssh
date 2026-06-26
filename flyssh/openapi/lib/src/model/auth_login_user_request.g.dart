// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_login_user_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthLoginUserRequestCWProxy {
  AuthLoginUserRequest masterKeyHash(String masterKeyHash);

  AuthLoginUserRequest password(String password);

  AuthLoginUserRequest username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthLoginUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthLoginUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthLoginUserRequest call({
    String masterKeyHash,
    String password,
    String username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthLoginUserRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthLoginUserRequest.copyWith.fieldName(...)`
class _$AuthLoginUserRequestCWProxyImpl
    implements _$AuthLoginUserRequestCWProxy {
  const _$AuthLoginUserRequestCWProxyImpl(this._value);

  final AuthLoginUserRequest _value;

  @override
  AuthLoginUserRequest masterKeyHash(String masterKeyHash) =>
      this(masterKeyHash: masterKeyHash);

  @override
  AuthLoginUserRequest password(String password) => this(password: password);

  @override
  AuthLoginUserRequest username(String username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthLoginUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthLoginUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthLoginUserRequest call({
    Object? masterKeyHash = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return AuthLoginUserRequest(
      masterKeyHash: masterKeyHash == const $CopyWithPlaceholder()
          ? _value.masterKeyHash
          // ignore: cast_nullable_to_non_nullable
          : masterKeyHash as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
    );
  }
}

extension $AuthLoginUserRequestCopyWith on AuthLoginUserRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthLoginUserRequest.copyWith(...)` or like so:`instanceOfAuthLoginUserRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthLoginUserRequestCWProxy get copyWith =>
      _$AuthLoginUserRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLoginUserRequest _$AuthLoginUserRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthLoginUserRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['masterKeyHash', 'password', 'username'],
  );
  final val = AuthLoginUserRequest(
    masterKeyHash: $checkedConvert('masterKeyHash', (v) => v as String),
    password: $checkedConvert('password', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AuthLoginUserRequestToJson(
  AuthLoginUserRequest instance,
) => <String, dynamic>{
  'masterKeyHash': instance.masterKeyHash,
  'password': instance.password,
  'username': instance.username,
};
