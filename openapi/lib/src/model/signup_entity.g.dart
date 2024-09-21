// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignupEntity extends SignupEntity {
  @override
  final String token;
  @override
  final UserEntity user;
  @override
  final String masterkey;

  factory _$SignupEntity([void Function(SignupEntityBuilder)? updates]) =>
      (new SignupEntityBuilder()..update(updates))._build();

  _$SignupEntity._(
      {required this.token, required this.user, required this.masterkey})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(token, r'SignupEntity', 'token');
    BuiltValueNullFieldError.checkNotNull(user, r'SignupEntity', 'user');
    BuiltValueNullFieldError.checkNotNull(
        masterkey, r'SignupEntity', 'masterkey');
  }

  @override
  SignupEntity rebuild(void Function(SignupEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignupEntityBuilder toBuilder() => new SignupEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignupEntity &&
        token == other.token &&
        user == other.user &&
        masterkey == other.masterkey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, masterkey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignupEntity')
          ..add('token', token)
          ..add('user', user)
          ..add('masterkey', masterkey))
        .toString();
  }
}

class SignupEntityBuilder
    implements Builder<SignupEntity, SignupEntityBuilder> {
  _$SignupEntity? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  UserEntityBuilder? _user;
  UserEntityBuilder get user => _$this._user ??= new UserEntityBuilder();
  set user(UserEntityBuilder? user) => _$this._user = user;

  String? _masterkey;
  String? get masterkey => _$this._masterkey;
  set masterkey(String? masterkey) => _$this._masterkey = masterkey;

  SignupEntityBuilder() {
    SignupEntity._defaults(this);
  }

  SignupEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _user = $v.user.toBuilder();
      _masterkey = $v.masterkey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignupEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignupEntity;
  }

  @override
  void update(void Function(SignupEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignupEntity build() => _build();

  _$SignupEntity _build() {
    _$SignupEntity _$result;
    try {
      _$result = _$v ??
          new _$SignupEntity._(
              token: BuiltValueNullFieldError.checkNotNull(
                  token, r'SignupEntity', 'token'),
              user: user.build(),
              masterkey: BuiltValueNullFieldError.checkNotNull(
                  masterkey, r'SignupEntity', 'masterkey'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'SignupEntity', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
