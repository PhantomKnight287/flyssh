// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_host.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PartialHost extends PartialHost {
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

  factory _$PartialHost([void Function(PartialHostBuilder)? updates]) =>
      (new PartialHostBuilder()..update(updates))._build();

  _$PartialHost._(
      {required this.id,
      required this.label,
      required this.username,
      required this.port,
      required this.hostname})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PartialHost', 'id');
    BuiltValueNullFieldError.checkNotNull(label, r'PartialHost', 'label');
    BuiltValueNullFieldError.checkNotNull(username, r'PartialHost', 'username');
    BuiltValueNullFieldError.checkNotNull(port, r'PartialHost', 'port');
    BuiltValueNullFieldError.checkNotNull(hostname, r'PartialHost', 'hostname');
  }

  @override
  PartialHost rebuild(void Function(PartialHostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PartialHostBuilder toBuilder() => new PartialHostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PartialHost &&
        id == other.id &&
        label == other.label &&
        username == other.username &&
        port == other.port &&
        hostname == other.hostname;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, port.hashCode);
    _$hash = $jc(_$hash, hostname.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PartialHost')
          ..add('id', id)
          ..add('label', label)
          ..add('username', username)
          ..add('port', port)
          ..add('hostname', hostname))
        .toString();
  }
}

class PartialHostBuilder implements Builder<PartialHost, PartialHostBuilder> {
  _$PartialHost? _$v;

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

  PartialHostBuilder() {
    PartialHost._defaults(this);
  }

  PartialHostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _username = $v.username;
      _port = $v.port;
      _hostname = $v.hostname;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PartialHost other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PartialHost;
  }

  @override
  void update(void Function(PartialHostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PartialHost build() => _build();

  _$PartialHost _build() {
    final _$result = _$v ??
        new _$PartialHost._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PartialHost', 'id'),
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'PartialHost', 'label'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'PartialHost', 'username'),
            port: BuiltValueNullFieldError.checkNotNull(
                port, r'PartialHost', 'port'),
            hostname: BuiltValueNullFieldError.checkNotNull(
                hostname, r'PartialHost', 'hostname'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
