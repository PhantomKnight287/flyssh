// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys_update_key_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KeysUpdateKeyRequestCWProxy {
  KeysUpdateKeyRequest iv(String? iv);

  KeysUpdateKeyRequest label(String? label);

  KeysUpdateKeyRequest passphrase(String? passphrase);

  KeysUpdateKeyRequest value(String? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysUpdateKeyRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysUpdateKeyRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysUpdateKeyRequest call({
    String? iv,
    String? label,
    String? passphrase,
    String? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKeysUpdateKeyRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKeysUpdateKeyRequest.copyWith.fieldName(...)`
class _$KeysUpdateKeyRequestCWProxyImpl
    implements _$KeysUpdateKeyRequestCWProxy {
  const _$KeysUpdateKeyRequestCWProxyImpl(this._value);

  final KeysUpdateKeyRequest _value;

  @override
  KeysUpdateKeyRequest iv(String? iv) => this(iv: iv);

  @override
  KeysUpdateKeyRequest label(String? label) => this(label: label);

  @override
  KeysUpdateKeyRequest passphrase(String? passphrase) =>
      this(passphrase: passphrase);

  @override
  KeysUpdateKeyRequest value(String? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysUpdateKeyRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysUpdateKeyRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysUpdateKeyRequest call({
    Object? iv = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? passphrase = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return KeysUpdateKeyRequest(
      iv: iv == const $CopyWithPlaceholder()
          ? _value.iv
          // ignore: cast_nullable_to_non_nullable
          : iv as String?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      passphrase: passphrase == const $CopyWithPlaceholder()
          ? _value.passphrase
          // ignore: cast_nullable_to_non_nullable
          : passphrase as String?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
    );
  }
}

extension $KeysUpdateKeyRequestCopyWith on KeysUpdateKeyRequest {
  /// Returns a callable class that can be used as follows: `instanceOfKeysUpdateKeyRequest.copyWith(...)` or like so:`instanceOfKeysUpdateKeyRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KeysUpdateKeyRequestCWProxy get copyWith =>
      _$KeysUpdateKeyRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeysUpdateKeyRequest _$KeysUpdateKeyRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('KeysUpdateKeyRequest', json, ($checkedConvert) {
  final val = KeysUpdateKeyRequest(
    iv: $checkedConvert('iv', (v) => v as String?),
    label: $checkedConvert('label', (v) => v as String?),
    passphrase: $checkedConvert('passphrase', (v) => v as String?),
    value: $checkedConvert('value', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$KeysUpdateKeyRequestToJson(
  KeysUpdateKeyRequest instance,
) => <String, dynamic>{
  'iv': ?instance.iv,
  'label': ?instance.label,
  'passphrase': ?instance.passphrase,
  'value': ?instance.value,
};
