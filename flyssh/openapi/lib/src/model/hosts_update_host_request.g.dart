// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hosts_update_host_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HostsUpdateHostRequestCWProxy {
  HostsUpdateHostRequest hostname(String? hostname);

  HostsUpdateHostRequest iv(String? iv);

  HostsUpdateHostRequest keyId(int? keyId);

  HostsUpdateHostRequest label(String? label);

  HostsUpdateHostRequest password(String? password);

  HostsUpdateHostRequest port(int? port);

  HostsUpdateHostRequest username(String? username);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsUpdateHostRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsUpdateHostRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsUpdateHostRequest call({
    String? hostname,
    String? iv,
    int? keyId,
    String? label,
    String? password,
    int? port,
    String? username,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHostsUpdateHostRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHostsUpdateHostRequest.copyWith.fieldName(...)`
class _$HostsUpdateHostRequestCWProxyImpl
    implements _$HostsUpdateHostRequestCWProxy {
  const _$HostsUpdateHostRequestCWProxyImpl(this._value);

  final HostsUpdateHostRequest _value;

  @override
  HostsUpdateHostRequest hostname(String? hostname) => this(hostname: hostname);

  @override
  HostsUpdateHostRequest iv(String? iv) => this(iv: iv);

  @override
  HostsUpdateHostRequest keyId(int? keyId) => this(keyId: keyId);

  @override
  HostsUpdateHostRequest label(String? label) => this(label: label);

  @override
  HostsUpdateHostRequest password(String? password) => this(password: password);

  @override
  HostsUpdateHostRequest port(int? port) => this(port: port);

  @override
  HostsUpdateHostRequest username(String? username) => this(username: username);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HostsUpdateHostRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HostsUpdateHostRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  HostsUpdateHostRequest call({
    Object? hostname = const $CopyWithPlaceholder(),
    Object? iv = const $CopyWithPlaceholder(),
    Object? keyId = const $CopyWithPlaceholder(),
    Object? label = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? port = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
  }) {
    return HostsUpdateHostRequest(
      hostname: hostname == const $CopyWithPlaceholder()
          ? _value.hostname
          // ignore: cast_nullable_to_non_nullable
          : hostname as String?,
      iv: iv == const $CopyWithPlaceholder()
          ? _value.iv
          // ignore: cast_nullable_to_non_nullable
          : iv as String?,
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
      username: username == const $CopyWithPlaceholder()
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String?,
    );
  }
}

extension $HostsUpdateHostRequestCopyWith on HostsUpdateHostRequest {
  /// Returns a callable class that can be used as follows: `instanceOfHostsUpdateHostRequest.copyWith(...)` or like so:`instanceOfHostsUpdateHostRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HostsUpdateHostRequestCWProxy get copyWith =>
      _$HostsUpdateHostRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostsUpdateHostRequest _$HostsUpdateHostRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('HostsUpdateHostRequest', json, ($checkedConvert) {
  final val = HostsUpdateHostRequest(
    hostname: $checkedConvert('hostname', (v) => v as String?),
    iv: $checkedConvert('iv', (v) => v as String?),
    keyId: $checkedConvert('keyId', (v) => (v as num?)?.toInt()),
    label: $checkedConvert('label', (v) => v as String?),
    password: $checkedConvert('password', (v) => v as String?),
    port: $checkedConvert('port', (v) => (v as num?)?.toInt()),
    username: $checkedConvert('username', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$HostsUpdateHostRequestToJson(
  HostsUpdateHostRequest instance,
) => <String, dynamic>{
  'hostname': ?instance.hostname,
  'iv': ?instance.iv,
  'keyId': ?instance.keyId,
  'label': ?instance.label,
  'password': ?instance.password,
  'port': ?instance.port,
  'username': ?instance.username,
};
