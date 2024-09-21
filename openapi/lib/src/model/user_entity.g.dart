// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserEntity extends UserEntity {
  @override
  final String username;
  @override
  final String name;

  factory _$UserEntity([void Function(UserEntityBuilder)? updates]) =>
      (new UserEntityBuilder()..update(updates))._build();

  _$UserEntity._({required this.username, required this.name}) : super._() {
    BuiltValueNullFieldError.checkNotNull(username, r'UserEntity', 'username');
    BuiltValueNullFieldError.checkNotNull(name, r'UserEntity', 'name');
  }

  @override
  UserEntity rebuild(void Function(UserEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserEntityBuilder toBuilder() => new UserEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserEntity &&
        username == other.username &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserEntity')
          ..add('username', username)
          ..add('name', name))
        .toString();
  }
}

class UserEntityBuilder implements Builder<UserEntity, UserEntityBuilder> {
  _$UserEntity? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  UserEntityBuilder() {
    UserEntity._defaults(this);
  }

  UserEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserEntity;
  }

  @override
  void update(void Function(UserEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserEntity build() => _build();

  _$UserEntity _build() {
    final _$result = _$v ??
        new _$UserEntity._(
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'UserEntity', 'username'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'UserEntity', 'name'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
