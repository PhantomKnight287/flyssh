// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_recover_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthRecoverRequestCWProxy {
  AuthRecoverRequest password(String password);

  AuthRecoverRequest recoveryKey(String recoveryKey);

  AuthRecoverRequest username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRecoverRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRecoverRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRecoverRequest call({
    String password,
    String recoveryKey,
    String username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthRecoverRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthRecoverRequest.copyWith.fieldName(...)`
class _$AuthRecoverRequestCWProxyImpl implements _$AuthRecoverRequestCWProxy {
  const _$AuthRecoverRequestCWProxyImpl(this._value);

  final AuthRecoverRequest _value;

  @override
  AuthRecoverRequest password(String password) => this(password: password);

  @override
  AuthRecoverRequest recoveryKey(String recoveryKey) =>
      this(recoveryKey: recoveryKey);

  @override
  AuthRecoverRequest username(String username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRecoverRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRecoverRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRecoverRequest call({
    Object? password = const $CopyWithPlaceholder(),
    Object? recoveryKey = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return AuthRecoverRequest(
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      recoveryKey: recoveryKey == const $CopyWithPlaceholder()
          ? _value.recoveryKey
          // ignore: cast_nullable_to_non_nullable
          : recoveryKey as String,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
    );
  }
}

extension $AuthRecoverRequestCopyWith on AuthRecoverRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthRecoverRequest.copyWith(...)` or like so:`instanceOfAuthRecoverRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthRecoverRequestCWProxy get copyWith =>
      _$AuthRecoverRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRecoverRequest _$AuthRecoverRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthRecoverRequest', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['password', 'recoveryKey', 'username'],
      );
      final val = AuthRecoverRequest(
        password: $checkedConvert('password', (v) => v as String),
        recoveryKey: $checkedConvert('recoveryKey', (v) => v as String),
        username: $checkedConvert('username', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AuthRecoverRequestToJson(AuthRecoverRequest instance) =>
    <String, dynamic>{
      'password': instance.password,
      'recoveryKey': instance.recoveryKey,
      'username': instance.username,
    };
