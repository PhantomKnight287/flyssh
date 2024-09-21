// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_host_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateHostDto extends UpdateHostDto {
  @override
  final String? label;
  @override
  final String? hostname;
  @override
  final String? username;
  @override
  final String? password;
  @override
  final String? keyId;

  factory _$UpdateHostDto([void Function(UpdateHostDtoBuilder)? updates]) =>
      (new UpdateHostDtoBuilder()..update(updates))._build();

  _$UpdateHostDto._(
      {this.label, this.hostname, this.username, this.password, this.keyId})
      : super._();

  @override
  UpdateHostDto rebuild(void Function(UpdateHostDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateHostDtoBuilder toBuilder() => new UpdateHostDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateHostDto &&
        label == other.label &&
        hostname == other.hostname &&
        username == other.username &&
        password == other.password &&
        keyId == other.keyId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, hostname.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, keyId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateHostDto')
          ..add('label', label)
          ..add('hostname', hostname)
          ..add('username', username)
          ..add('password', password)
          ..add('keyId', keyId))
        .toString();
  }
}

class UpdateHostDtoBuilder
    implements Builder<UpdateHostDto, UpdateHostDtoBuilder> {
  _$UpdateHostDto? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _hostname;
  String? get hostname => _$this._hostname;
  set hostname(String? hostname) => _$this._hostname = hostname;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _keyId;
  String? get keyId => _$this._keyId;
  set keyId(String? keyId) => _$this._keyId = keyId;

  UpdateHostDtoBuilder() {
    UpdateHostDto._defaults(this);
  }

  UpdateHostDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _hostname = $v.hostname;
      _username = $v.username;
      _password = $v.password;
      _keyId = $v.keyId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateHostDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateHostDto;
  }

  @override
  void update(void Function(UpdateHostDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateHostDto build() => _build();

  _$UpdateHostDto _build() {
    final _$result = _$v ??
        new _$UpdateHostDto._(
            label: label,
            hostname: hostname,
            username: username,
            password: password,
            keyId: keyId);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
