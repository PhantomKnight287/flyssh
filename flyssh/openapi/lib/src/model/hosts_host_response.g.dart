// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hosts_host_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostsHostResponseCWProxy {
  HostsHostResponse createdAt(String? createdAt);

  HostsHostResponse hostname(String? hostname);

  HostsHostResponse id(int? id);

  HostsHostResponse iv(String? iv);

  HostsHostResponse key(KeysKeyResponse? key);

  HostsHostResponse keyId(int? keyId);

  HostsHostResponse label(String? label);

  HostsHostResponse password(String? password);

  HostsHostResponse port(int? port);

  HostsHostResponse updatedAt(String? updatedAt);

  HostsHostResponse username(String? username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsHostResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsHostResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsHostResponse call({
    String? createdAt,
    String? hostname,
    int? id,
    String? iv,
    KeysKeyResponse? key,
    int? keyId,
    String? label,
    String? password,
    int? port,
    String? updatedAt,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostsHostResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostsHostResponse.copyWith.fieldName(...)`
class _$HostsHostResponseCWProxyImpl implements _$HostsHostResponseCWProxy {
  const _$HostsHostResponseCWProxyImpl(this._value);

  final HostsHostResponse _value;

  @override
  HostsHostResponse createdAt(String? createdAt) => this(createdAt: createdAt);

  @override
  HostsHostResponse hostname(String? hostname) => this(hostname: hostname);

  @override
  HostsHostResponse id(int? id) => this(id: id);

  @override
  HostsHostResponse iv(String? iv) => this(iv: iv);

  @override
  HostsHostResponse key(KeysKeyResponse? key) => this(key: key);

  @override
  HostsHostResponse keyId(int? keyId) => this(keyId: keyId);

  @override
  HostsHostResponse label(String? label) => this(label: label);

  @override
  HostsHostResponse password(String? password) => this(password: password);

  @override
  HostsHostResponse port(int? port) => this(port: port);

  @override
  HostsHostResponse updatedAt(String? updatedAt) => this(updatedAt: updatedAt);

  @override
  HostsHostResponse username(String? username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsHostResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsHostResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsHostResponse call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? hostname = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? iv = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? keyId = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? port = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return HostsHostResponse(
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String?,
      hostname: hostname == const $CopyWithPlaceholder()
          ? _value.hostname
          // ignore: cast_nullable_to_non_nullable
          : hostname as String?,
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      iv: iv == const $CopyWithPlaceholder()
          ? _value.iv
          // ignore: cast_nullable_to_non_nullable
          : iv as String?,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as KeysKeyResponse?,
      keyId: keyId == const $CopyWithPlaceholder()
          ? _value.keyId
          // ignore: cast_nullable_to_non_nullable
          : keyId as int?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String?,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      port: port == const $CopyWithPlaceholder()
          ? _value.port
          // ignore: cast_nullable_to_non_nullable
          : port as int?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as String?,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String?,
    );
  }
}

extension $HostsHostResponseCopyWith on HostsHostResponse {
  /// Returns a callable class that can be used as follows: `instanceOfHostsHostResponse.copyWith(...)` or like so:`instanceOfHostsHostResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostsHostResponseCWProxy get copyWith =>
      _$HostsHostResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostsHostResponse _$HostsHostResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HostsHostResponse', json, ($checkedConvert) {
      final val = HostsHostResponse(
        createdAt: $checkedConvert('createdAt', (v) => v as String?),
        hostname: $checkedConvert('hostname', (v) => v as String?),
        id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
        iv: $checkedConvert('iv', (v) => v as String?),
        key: $checkedConvert(
          'key',
          (v) => v == null
              ? null
              : KeysKeyResponse.fromJson(v as Map<String, dynamic>),
        ),
        keyId: $checkedConvert('keyId', (v) => (v as num?)?.toInt()),
        label: $checkedConvert('label', (v) => v as String?),
        password: $checkedConvert('password', (v) => v as String?),
        port: $checkedConvert('port', (v) => (v as num?)?.toInt()),
        updatedAt: $checkedConvert('updatedAt', (v) => v as String?),
        username: $checkedConvert('username', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$HostsHostResponseToJson(HostsHostResponse instance) =>
    <String, dynamic>{
      'createdAt': ?instance.createdAt,
      'hostname': ?instance.hostname,
      'id': ?instance.id,
      'iv': ?instance.iv,
      'key': ?instance.key?.toJson(),
      'keyId': ?instance.keyId,
      'label': ?instance.label,
      'password': ?instance.password,
      'port': ?instance.port,
      'updatedAt': ?instance.updatedAt,
      'username': ?instance.username,
    };
