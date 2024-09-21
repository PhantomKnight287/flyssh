// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignupDTO extends SignupDTO {
  @override
  final String username;
  @override
  final String password;
  @override
  final String name;

  factory _$SignupDTO([void Function(SignupDTOBuilder)? updates]) =>
      (new SignupDTOBuilder()..update(updates))._build();

  _$SignupDTO._(
      {required this.username, required this.password, required this.name})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(username, r'SignupDTO', 'username');
    BuiltValueNullFieldError.checkNotNull(password, r'SignupDTO', 'password');
    BuiltValueNullFieldError.checkNotNull(name, r'SignupDTO', 'name');
  }

  @override
  SignupDTO rebuild(void Function(SignupDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignupDTOBuilder toBuilder() => new SignupDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignupDTO &&
        username == other.username &&
        password == other.password &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignupDTO')
          ..add('username', username)
          ..add('password', password)
          ..add('name', name))
        .toString();
  }
}

class SignupDTOBuilder implements Builder<SignupDTO, SignupDTOBuilder> {
  _$SignupDTO? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  SignupDTOBuilder() {
    SignupDTO._defaults(this);
  }

  SignupDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignupDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignupDTO;
  }

  @override
  void update(void Function(SignupDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignupDTO build() => _build();

  _$SignupDTO _build() {
    final _$result = _$v ??
        new _$SignupDTO._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'SignupDTO', 'username'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'SignupDTO', 'password'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'SignupDTO', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
