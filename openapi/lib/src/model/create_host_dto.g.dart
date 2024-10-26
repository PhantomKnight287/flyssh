// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_host_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateHostDto extends CreateHostDto {
  @override
  final String label;
  @override
  final String hostname;
  @override
  final String username;
  @override
  final num? port;
  @override
  final String? password;
  @override
  final String? keyId;
  @override
  final String? iv;

  factory _$CreateHostDto([void Function(CreateHostDtoBuilder)? updates]) =>
      (new CreateHostDtoBuilder()..update(updates))._build();

  _$CreateHostDto._(
      {required this.label,
      required this.hostname,
      required this.username,
      this.port,
      this.password,
      this.keyId,
      this.iv})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'CreateHostDto', 'label');
    BuiltValueNullFieldError.checkNotNull(
        hostname, r'CreateHostDto', 'hostname');
    BuiltValueNullFieldError.checkNotNull(
        username, r'CreateHostDto', 'username');
  }

  @override
  CreateHostDto rebuild(void Function(CreateHostDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateHostDtoBuilder toBuilder() => new CreateHostDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateHostDto &&
        label == other.label &&
        hostname == other.hostname &&
        username == other.username &&
        port == other.port &&
        password == other.password &&
        keyId == other.keyId &&
        iv == other.iv;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, hostname.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, port.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, keyId.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateHostDto')
          ..add('label', label)
          ..add('hostname', hostname)
          ..add('username', username)
          ..add('port', port)
          ..add('password', password)
          ..add('keyId', keyId)
          ..add('iv', iv))
        .toString();
  }
}

class CreateHostDtoBuilder
    implements Builder<CreateHostDto, CreateHostDtoBuilder> {
  _$CreateHostDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _hostname;
  String? get hostname => _$this._hostname;
  set hostname(String? hostname) => _$this._hostname = hostname;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  num? _port;
  num? get port => _$this._port;
  set port(num? port) => _$this._port = port;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _keyId;
  String? get keyId => _$this._keyId;
  set keyId(String? keyId) => _$this._keyId = keyId;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  CreateHostDtoBuilder() {
    CreateHostDto._defaults(this);
  }

  CreateHostDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _hostname = $v.hostname;
      _username = $v.username;
      _port = $v.port;
      _password = $v.password;
      _keyId = $v.keyId;
      _iv = $v.iv;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateHostDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateHostDto;
  }

  @override
  void update(void Function(CreateHostDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateHostDto build() => _build();

  _$CreateHostDto _build() {
    final _$result = _$v ??
        new _$CreateHostDto._(
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'CreateHostDto', 'label'),
            hostname: BuiltValueNullFieldError.checkNotNull(
                hostname, r'CreateHostDto', 'hostname'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'CreateHostDto', 'username'),
            port: port,
            password: password,
            keyId: keyId,
            iv: iv);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
