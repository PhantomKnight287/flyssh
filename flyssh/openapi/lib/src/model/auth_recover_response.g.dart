// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_recover_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthRecoverResponseCWProxy {
  AuthRecoverResponse encryptedMasterKey(String? encryptedMasterKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRecoverResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRecoverResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRecoverResponse call({String? encryptedMasterKey});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthRecoverResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthRecoverResponse.copyWith.fieldName(...)`
class _$AuthRecoverResponseCWProxyImpl implements _$AuthRecoverResponseCWProxy {
  const _$AuthRecoverResponseCWProxyImpl(this._value);

  final AuthRecoverResponse _value;

  @override
  AuthRecoverResponse encryptedMasterKey(String? encryptedMasterKey) =>
      this(encryptedMasterKey: encryptedMasterKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthRecoverResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthRecoverResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthRecoverResponse call({
    Object? encryptedMasterKey = const $CopyWithPlaceholder(),
  }) {
    return AuthRecoverResponse(
      encryptedMasterKey: encryptedMasterKey == const $CopyWithPlaceholder()
          ? _value.encryptedMasterKey
          // ignore: cast_nullable_to_non_nullable
          : encryptedMasterKey as String?,
    );
  }
}

extension $AuthRecoverResponseCopyWith on AuthRecoverResponse {
  /// Returns a callable class that can be used as follows: `instanceOfAuthRecoverResponse.copyWith(...)` or like so:`instanceOfAuthRecoverResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthRecoverResponseCWProxy get copyWith =>
      _$AuthRecoverResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRecoverResponse _$AuthRecoverResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AuthRecoverResponse', json, ($checkedConvert) {
      final val = AuthRecoverResponse(
        encryptedMasterKey: $checkedConvert(
          'encryptedMasterKey',
          (v) => v as String?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$AuthRecoverResponseToJson(
  AuthRecoverResponse instance,
) => <String, dynamic>{'encryptedMasterKey': ?instance.encryptedMasterKey};
