// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Host extends Host {
  @override
  final String id;
  @override
  final String label;
  @override
  final String username;
  @override
  final num port;
  @override
  final String hostname;
  @override
  final String iv;
  @override
  final String? password;
  @override
  final KeyEntity? key;

  factory _$Host([void Function(HostBuilder)? updates]) =>
      (new HostBuilder()..update(updates))._build();

  _$Host._(
      {required this.id,
      required this.label,
      required this.username,
      required this.port,
      required this.hostname,
      required this.iv,
      this.password,
      this.key})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Host', 'id');
    BuiltValueNullFieldError.checkNotNull(label, r'Host', 'label');
    BuiltValueNullFieldError.checkNotNull(username, r'Host', 'username');
    BuiltValueNullFieldError.checkNotNull(port, r'Host', 'port');
    BuiltValueNullFieldError.checkNotNull(hostname, r'Host', 'hostname');
    BuiltValueNullFieldError.checkNotNull(iv, r'Host', 'iv');
  }

  @override
  Host rebuild(void Function(HostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HostBuilder toBuilder() => new HostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Host &&
        id == other.id &&
        label == other.label &&
        username == other.username &&
        port == other.port &&
        hostname == other.hostname &&
        iv == other.iv &&
        password == other.password &&
        key == other.key;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, port.hashCode);
    _$hash = $jc(_$hash, hostname.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Host')
          ..add('id', id)
          ..add('label', label)
          ..add('username', username)
          ..add('port', port)
          ..add('hostname', hostname)
          ..add('iv', iv)
          ..add('password', password)
          ..add('key', key))
        .toString();
  }
}

class HostBuilder implements Builder<Host, HostBuilder> {
  _$Host? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  num? _port;
  num? get port => _$this._port;
  set port(num? port) => _$this._port = port;

  String? _hostname;
  String? get hostname => _$this._hostname;
  set hostname(String? hostname) => _$this._hostname = hostname;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  KeyEntityBuilder? _key;
  KeyEntityBuilder get key => _$this._key ??= new KeyEntityBuilder();
  set key(KeyEntityBuilder? key) => _$this._key = key;

  HostBuilder() {
    Host._defaults(this);
  }

  HostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _username = $v.username;
      _port = $v.port;
      _hostname = $v.hostname;
      _iv = $v.iv;
      _password = $v.password;
      _key = $v.key?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Host other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Host;
  }

  @override
  void update(void Function(HostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Host build() => _build();

  _$Host _build() {
    _$Host _$result;
    try {
      _$result = _$v ??
          new _$Host._(
              id: BuiltValueNullFieldError.checkNotNull(id, r'Host', 'id'),
              label: BuiltValueNullFieldError.checkNotNull(
                  label, r'Host', 'label'),
              username: BuiltValueNullFieldError.checkNotNull(
                  username, r'Host', 'username'),
              port:
                  BuiltValueNullFieldError.checkNotNull(port, r'Host', 'port'),
              hostname: BuiltValueNullFieldError.checkNotNull(
                  hostname, r'Host', 'hostname'),
              iv: BuiltValueNullFieldError.checkNotNull(iv, r'Host', 'iv'),
              password: password,
              key: _key?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'key';
        _key?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Host', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
