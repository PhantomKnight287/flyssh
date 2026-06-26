// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys_key_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$KeysKeyResponseCWProxy {
  KeysKeyResponse createdAt(String? createdAt);

  KeysKeyResponse id(int? id);

  KeysKeyResponse iv(String? iv);

  KeysKeyResponse label(String? label);

  KeysKeyResponse passphrase(String? passphrase);

  KeysKeyResponse updatedAt(String? updatedAt);

  KeysKeyResponse value(String? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysKeyResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysKeyResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysKeyResponse call({
    String? createdAt,
    int? id,
    String? iv,
    String? label,
    String? passphrase,
    String? updatedAt,
    String? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfKeysKeyResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfKeysKeyResponse.copyWith.fieldName(...)`
class _$KeysKeyResponseCWProxyImpl implements _$KeysKeyResponseCWProxy {
  const _$KeysKeyResponseCWProxyImpl(this._value);

  final KeysKeyResponse _value;

  @override
  KeysKeyResponse createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  KeysKeyResponse id(int? id) => this(id: id);

  @override
  KeysKeyResponse iv(String? iv) => this(iv: iv);

  @override
  KeysKeyResponse label(String? label) => this(label: label);

  @override
  KeysKeyResponse passphrase(String? passphrase) =>
      this(passphrase: passphrase);

  @override
  KeysKeyResponse updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  KeysKeyResponse value(String? value) => this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `KeysKeyResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// KeysKeyResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  KeysKeyResponse call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? iv = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? passphrase = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return KeysKeyResponse(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
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
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
    );
  }
}

extension $KeysKeyResponseCopyWith on KeysKeyResponse {
  /// Returns a callable class that can be used as follows: `instanceOfKeysKeyResponse.copyWith(...)` or like so:`instanceOfKeysKeyResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$KeysKeyResponseCWProxy get copyWith => _$KeysKeyResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeysKeyResponse _$KeysKeyResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('KeysKeyResponse', json, ($checkedConvert) {
      final val = KeysKeyResponse(
        createdAt: $checkedConvert('createdAt', (v) => v as String?),
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        iv: $checkedConvert('iv', (v) => v as String?),
        label: $checkedConvert('label', (v) => v as String?),
        passphrase: $checkedConvert('passphrase', (v) => v as String?),
        updatedAt: $checkedConvert('updatedAt', (v) => v as String?),
        value: $checkedConvert('value', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$KeysKeyResponseToJson(KeysKeyResponse instance) =>
    <String, dynamic>{
      'createdAt': ?instance.createdAt,
      'id': ?instance.id,
      'iv': ?instance.iv,
      'label': ?instance.label,
      'passphrase': ?instance.passphrase,
      'updatedAt': ?instance.updatedAt,
      'value': ?instance.value,
    };
