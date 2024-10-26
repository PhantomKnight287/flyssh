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
  final String? password;
  @override
  final String iv;
  @override
  final String hostname;

  factory _$Host([void Function(HostBuilder)? updates]) =>
      (new HostBuilder()..update(updates))._build();

  _$Host._(
      {required this.id,
      required this.label,
      required this.username,
      required this.port,
      this.password,
      required this.iv,
      required this.hostname})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'Host', 'id');
    BuiltValueNullFieldError.checkNotNull(label, r'Host', 'label');
    BuiltValueNullFieldError.checkNotNull(username, r'Host', 'username');
    BuiltValueNullFieldError.checkNotNull(port, r'Host', 'port');
    BuiltValueNullFieldError.checkNotNull(iv, r'Host', 'iv');
    BuiltValueNullFieldError.checkNotNull(hostname, r'Host', 'hostname');
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
        password == other.password &&
        iv == other.iv &&
        hostname == other.hostname;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, port.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jc(_$hash, hostname.hashCode);
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
          ..add('password', password)
          ..add('iv', iv)
          ..add('hostname', hostname))
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

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  String? _hostname;
  String? get hostname => _$this._hostname;
  set hostname(String? hostname) => _$this._hostname = hostname;

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
      _password = $v.password;
      _iv = $v.iv;
      _hostname = $v.hostname;
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
    final _$result = _$v ??
        new _$Host._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Host', 'id'),
            label:
                BuiltValueNullFieldError.checkNotNull(label, r'Host', 'label'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'Host', 'username'),
            port: BuiltValueNullFieldError.checkNotNull(port, r'Host', 'port'),
            password: password,
            iv: BuiltValueNullFieldError.checkNotNull(iv, r'Host', 'iv'),
            hostname: BuiltValueNullFieldError.checkNotNull(
                hostname, r'Host', 'hostname'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
