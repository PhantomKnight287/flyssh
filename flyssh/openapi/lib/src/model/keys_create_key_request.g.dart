// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys_create_key_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KeysCreateKeyRequestCWProxy {
  KeysCreateKeyRequest iv(String iv);

  KeysCreateKeyRequest label(String label);

  KeysCreateKeyRequest passphrase(String? passphrase);

  KeysCreateKeyRequest value(String value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysCreateKeyRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysCreateKeyRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysCreateKeyRequest call({
    String iv,
    String label,
    String? passphrase,
    String value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKeysCreateKeyRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKeysCreateKeyRequest.copyWith.fieldName(...)`
class _$KeysCreateKeyRequestCWProxyImpl
    implements _$KeysCreateKeyRequestCWProxy {
  const _$KeysCreateKeyRequestCWProxyImpl(this._value);

  final KeysCreateKeyRequest _value;

  @override
  KeysCreateKeyRequest iv(String iv) => this(iv: iv);

  @override
  KeysCreateKeyRequest label(String label) => this(label: label);

  @override
  KeysCreateKeyRequest passphrase(String? passphrase) =>
      this(passphrase: passphrase);

  @override
  KeysCreateKeyRequest value(String value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysCreateKeyRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysCreateKeyRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysCreateKeyRequest call({
    Object? iv = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? passphrase = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return KeysCreateKeyRequest(
      iv: iv == const $CopyWithPlaceholder()
          ? _value.iv
          // ignore: cast_nullable_to_non_nullable
          : iv as String,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      passphrase: passphrase == const $CopyWithPlaceholder()
          ? _value.passphrase
          // ignore: cast_nullable_to_non_nullable
          : passphrase as String?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
    );
  }
}

extension $KeysCreateKeyRequestCopyWith on KeysCreateKeyRequest {
  /// Returns a callable class that can be used as follows: `instanceOfKeysCreateKeyRequest.copyWith(...)` or like so:`instanceOfKeysCreateKeyRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KeysCreateKeyRequestCWProxy get copyWith =>
      _$KeysCreateKeyRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeysCreateKeyRequest _$KeysCreateKeyRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('KeysCreateKeyRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['iv', 'label', 'value']);
  final val = KeysCreateKeyRequest(
    iv: $checkedConvert('iv', (v) => v as String),
    label: $checkedConvert('label', (v) => v as String),
    passphrase: $checkedConvert('passphrase', (v) => v as String?),
    value: $checkedConvert('value', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$KeysCreateKeyRequestToJson(
  KeysCreateKeyRequest instance,
) => <String, dynamic>{
  'iv': instance.iv,
  'label': instance.label,
  'passphrase': ?instance.passphrase,
  'value': instance.value,
};
