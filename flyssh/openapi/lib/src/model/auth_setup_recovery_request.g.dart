// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_setup_recovery_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AuthSetupRecoveryRequestCWProxy {
  AuthSetupRecoveryRequest encryptedMasterKey(String encryptedMasterKey);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSetupRecoveryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSetupRecoveryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSetupRecoveryRequest call({String encryptedMasterKey});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAuthSetupRecoveryRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAuthSetupRecoveryRequest.copyWith.fieldName(...)`
class _$AuthSetupRecoveryRequestCWProxyImpl
    implements _$AuthSetupRecoveryRequestCWProxy {
  const _$AuthSetupRecoveryRequestCWProxyImpl(this._value);

  final AuthSetupRecoveryRequest _value;

  @override
  AuthSetupRecoveryRequest encryptedMasterKey(String encryptedMasterKey) =>
      this(encryptedMasterKey: encryptedMasterKey);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AuthSetupRecoveryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AuthSetupRecoveryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  AuthSetupRecoveryRequest call({
    Object? encryptedMasterKey = const $CopyWithPlaceholder(),
  }) {
    return AuthSetupRecoveryRequest(
      encryptedMasterKey: encryptedMasterKey == const $CopyWithPlaceholder()
          ? _value.encryptedMasterKey
          // ignore: cast_nullable_to_non_nullable
          : encryptedMasterKey as String,
    );
  }
}

extension $AuthSetupRecoveryRequestCopyWith on AuthSetupRecoveryRequest {
  /// Returns a callable class that can be used as follows: `instanceOfAuthSetupRecoveryRequest.copyWith(...)` or like so:`instanceOfAuthSetupRecoveryRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AuthSetupRecoveryRequestCWProxy get copyWith =>
      _$AuthSetupRecoveryRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSetupRecoveryRequest _$AuthSetupRecoveryRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AuthSetupRecoveryRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['encryptedMasterKey']);
  final val = AuthSetupRecoveryRequest(
    encryptedMasterKey: $checkedConvert(
      'encryptedMasterKey',
      (v) => v as String,
    ),
  );
  return val;
});

Map<String, dynamic> _$AuthSetupRecoveryRequestToJson(
  AuthSetupRecoveryRequest instance,
) => <String, dynamic>{'encryptedMasterKey': instance.encryptedMasterKey};
