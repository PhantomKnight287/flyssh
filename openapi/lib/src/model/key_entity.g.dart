// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_entity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KeyEntity extends KeyEntity {
  @override
  final String label;
  @override
  final String id;
  @override
  final String value;
  @override
  final String? passphrase;
  @override
  final String iv;

  factory _$KeyEntity([void Function(KeyEntityBuilder)? updates]) =>
      (new KeyEntityBuilder()..update(updates))._build();

  _$KeyEntity._(
      {required this.label,
      required this.id,
      required this.value,
      this.passphrase,
      required this.iv})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'KeyEntity', 'label');
    BuiltValueNullFieldError.checkNotNull(id, r'KeyEntity', 'id');
    BuiltValueNullFieldError.checkNotNull(value, r'KeyEntity', 'value');
    BuiltValueNullFieldError.checkNotNull(iv, r'KeyEntity', 'iv');
  }

  @override
  KeyEntity rebuild(void Function(KeyEntityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyEntityBuilder toBuilder() => new KeyEntityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyEntity &&
        label == other.label &&
        id == other.id &&
        value == other.value &&
        passphrase == other.passphrase &&
        iv == other.iv;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, passphrase.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KeyEntity')
          ..add('label', label)
          ..add('id', id)
          ..add('value', value)
          ..add('passphrase', passphrase)
          ..add('iv', iv))
        .toString();
  }
}

class KeyEntityBuilder implements Builder<KeyEntity, KeyEntityBuilder> {
  _$KeyEntity? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _passphrase;
  String? get passphrase => _$this._passphrase;
  set passphrase(String? passphrase) => _$this._passphrase = passphrase;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  KeyEntityBuilder() {
    KeyEntity._defaults(this);
  }

  KeyEntityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _id = $v.id;
      _value = $v.value;
      _passphrase = $v.passphrase;
      _iv = $v.iv;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KeyEntity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$KeyEntity;
  }

  @override
  void update(void Function(KeyEntityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KeyEntity build() => _build();

  _$KeyEntity _build() {
    final _$result = _$v ??
        new _$KeyEntity._(
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'KeyEntity', 'label'),
            id: BuiltValueNullFieldError.checkNotNull(id, r'KeyEntity', 'id'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'KeyEntity', 'value'),
            passphrase: passphrase,
            iv: BuiltValueNullFieldError.checkNotNull(iv, r'KeyEntity', 'iv'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
