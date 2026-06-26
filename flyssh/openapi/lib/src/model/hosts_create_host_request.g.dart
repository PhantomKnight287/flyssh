// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hosts_create_host_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostsCreateHostRequestCWProxy {
  HostsCreateHostRequest hostname(String hostname);

  HostsCreateHostRequest iv(String iv);

  HostsCreateHostRequest keyId(int? keyId);

  HostsCreateHostRequest label(String label);

  HostsCreateHostRequest password(String? password);

  HostsCreateHostRequest port(int? port);

  HostsCreateHostRequest username(String username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsCreateHostRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsCreateHostRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsCreateHostRequest call({
    String hostname,
    String iv,
    int? keyId,
    String label,
    String? password,
    int? port,
    String username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostsCreateHostRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostsCreateHostRequest.copyWith.fieldName(...)`
class _$HostsCreateHostRequestCWProxyImpl
    implements _$HostsCreateHostRequestCWProxy {
  const _$HostsCreateHostRequestCWProxyImpl(this._value);

  final HostsCreateHostRequest _value;

  @override
  HostsCreateHostRequest hostname(String hostname) => this(hostname: hostname);

  @override
  HostsCreateHostRequest iv(String iv) => this(iv: iv);

  @override
  HostsCreateHostRequest keyId(int? keyId) => this(keyId: keyId);

  @override
  HostsCreateHostRequest label(String label) => this(label: label);

  @override
  HostsCreateHostRequest password(String? password) => this(password: password);

  @override
  HostsCreateHostRequest port(int? port) => this(port: port);

  @override
  HostsCreateHostRequest username(String username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsCreateHostRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsCreateHostRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsCreateHostRequest call({
    Object? hostname = const $CopyWithPlaceholder(),
    Object? iv = const $CopyWithPlaceholder(),
    Object? keyId = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? port = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return HostsCreateHostRequest(
      hostname: hostname == const $CopyWithPlaceholder()
          ? _value.hostname
          // ignore: cast_nullable_to_non_nullable
          : hostname as String,
      iv: iv == const $CopyWithPlaceholder()
          ? _value.iv
          // ignore: cast_nullable_to_non_nullable
          : iv as String,
      keyId: keyId == const $CopyWithPlaceholder()
          ? _value.keyId
          // ignore: cast_nullable_to_non_nullable
          : keyId as int?,
      label: label == const $CopyWithPlaceholder()
          ? _value.label
          // ignore: cast_nullable_to_non_nullable
          : label as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String?,
      port: port == const $CopyWithPlaceholder()
          ? _value.port
          // ignore: cast_nullable_to_non_nullable
          : port as int?,
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
    );
  }
}

extension $HostsCreateHostRequestCopyWith on HostsCreateHostRequest {
  /// Returns a callable class that can be used as follows: `instanceOfHostsCreateHostRequest.copyWith(...)` or like so:`instanceOfHostsCreateHostRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostsCreateHostRequestCWProxy get copyWith =>
      _$HostsCreateHostRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostsCreateHostRequest _$HostsCreateHostRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('HostsCreateHostRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['hostname', 'iv', 'label', 'username']);
  final val = HostsCreateHostRequest(
    hostname: $checkedConvert('hostname', (v) => v as String),
    iv: $checkedConvert('iv', (v) => v as String),
    keyId: $checkedConvert('keyId', (v) => (v as num?)?.toInt()),
    label: $checkedConvert('label', (v) => v as String),
    password: $checkedConvert('password', (v) => v as String?),
    port: $checkedConvert('port', (v) => (v as num?)?.toInt()),
    username: $checkedConvert('username', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$HostsCreateHostRequestToJson(
  HostsCreateHostRequest instance,
) => <String, dynamic>{
  'hostname': instance.hostname,
  'iv': instance.iv,
  'keyId': ?instance.keyId,
  'label': instance.label,
  'password': ?instance.password,
  'port': ?instance.port,
  'username': instance.username,
};
