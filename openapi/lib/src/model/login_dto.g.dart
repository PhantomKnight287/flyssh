// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LoginDTO extends LoginDTO {
  @override
  final String username;
  @override
  final String password;
  @override
  final String masterkey;

  factory _$LoginDTO([void Function(LoginDTOBuilder)? updates]) =>
      (new LoginDTOBuilder()..update(updates))._build();

  _$LoginDTO._(
      {required this.username, required this.password, required this.masterkey})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(username, r'LoginDTO', 'username');
    BuiltValueNullFieldError.checkNotNull(password, r'LoginDTO', 'password');
    BuiltValueNullFieldError.checkNotNull(masterkey, r'LoginDTO', 'masterkey');
  }

  @override
  LoginDTO rebuild(void Function(LoginDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LoginDTOBuilder toBuilder() => new LoginDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LoginDTO &&
        username == other.username &&
        password == other.password &&
        masterkey == other.masterkey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, masterkey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'LoginDTO')
          ..add('username', username)
          ..add('password', password)
          ..add('masterkey', masterkey))
        .toString();
  }
}

class LoginDTOBuilder implements Builder<LoginDTO, LoginDTOBuilder> {
  _$LoginDTO? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _masterkey;
  String? get masterkey => _$this._masterkey;
  set masterkey(String? masterkey) => _$this._masterkey = masterkey;

  LoginDTOBuilder() {
    LoginDTO._defaults(this);
  }

  LoginDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _masterkey = $v.masterkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LoginDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LoginDTO;
  }

  @override
  void update(void Function(LoginDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  LoginDTO build() => _build();

  _$LoginDTO _build() {
    final _$result = _$v ??
        new _$LoginDTO._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'LoginDTO', 'username'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'LoginDTO', 'password'),
            masterkey: BuiltValueNullFieldError.checkNotNull(
                masterkey, r'LoginDTO', 'masterkey'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
