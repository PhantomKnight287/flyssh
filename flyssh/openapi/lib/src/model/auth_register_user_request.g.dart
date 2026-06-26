// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_register_user_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthRegisterUserRequestCWProxy {
  AuthRegisterUserRequest masterKeyHash(String masterKeyHash);

  AuthRegisterUserRequest name(String name);

  AuthRegisterUserRequest password(String password);

  AuthRegisterUserRequest username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRegisterUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRegisterUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRegisterUserRequest call({
    String masterKeyHash,
    String name,
    String password,
    String username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthRegisterUserRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthRegisterUserRequest.copyWith.fieldName(...)`
class _$AuthRegisterUserRequestCWProxyImpl
    implements _$AuthRegisterUserRequestCWProxy {
  const _$AuthRegisterUserRequestCWProxyImpl(this._value);

  final AuthRegisterUserRequest _value;

  @override
  AuthRegisterUserRequest masterKeyHash(String masterKeyHash) =>
      this(masterKeyHash: masterKeyHash);

  @override
  AuthRegisterUserRequest name(String name) => this(name: name);

  @override
  AuthRegisterUserRequest password(String password) => this(password: password);

  @override
  AuthRegisterUserRequest username(String username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRegisterUserRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRegisterUserRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRegisterUserRequest call({
    Object? masterKeyHash = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return AuthRegisterUserRequest(
      masterKeyHash: masterKeyHash == const $CopyWithPlaceholder()
          ? _value.masterKeyHash
          // ignore: cast_nullable_to_non_nullable
          : masterKeyHash as String,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
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

extension $AuthRegisterUserRequestCopyWith on AuthRegisterUserRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthRegisterUserRequest.copyWith(...)` or like so:`instanceOfAuthRegisterUserRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthRegisterUserRequestCWProxy get copyWith =>
      _$AuthRegisterUserRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRegisterUserRequest _$AuthRegisterUserRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthRegisterUserRequest', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['masterKeyHash', 'name', 'password', 'username'],
  );
  final val = AuthRegisterUserRequest(
    masterKeyHash: $checkedConvert('masterKeyHash', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    password: $checkedConvert('password', (v) => v as String),
    username: $checkedConvert('username', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AuthRegisterUserRequestToJson(
  AuthRegisterUserRequest instance,
) => <String, dynamic>{
  'masterKeyHash': instance.masterKeyHash,
  'name': instance.name,
  'password': instance.password,
  'username': instance.username,
};
