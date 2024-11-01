// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_key.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PartialKey extends PartialKey {
  @override
  final String label;
  @override
  final String id;
  @override
  final Count count;
  @override
  final String value;
  @override
  final String? passphrase;
  @override
  final String iv;

  factory _$PartialKey([void Function(PartialKeyBuilder)? updates]) =>
      (new PartialKeyBuilder()..update(updates))._build();

  _$PartialKey._(
      {required this.label,
      required this.id,
      required this.count,
      required this.value,
      this.passphrase,
      required this.iv})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'PartialKey', 'label');
    BuiltValueNullFieldError.checkNotNull(id, r'PartialKey', 'id');
    BuiltValueNullFieldError.checkNotNull(count, r'PartialKey', 'count');
    BuiltValueNullFieldError.checkNotNull(value, r'PartialKey', 'value');
    BuiltValueNullFieldError.checkNotNull(iv, r'PartialKey', 'iv');
  }

  @override
  PartialKey rebuild(void Function(PartialKeyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PartialKeyBuilder toBuilder() => new PartialKeyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PartialKey &&
        label == other.label &&
        id == other.id &&
        count == other.count &&
        value == other.value &&
        passphrase == other.passphrase &&
        iv == other.iv;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, count.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, passphrase.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PartialKey')
          ..add('label', label)
          ..add('id', id)
          ..add('count', count)
          ..add('value', value)
          ..add('passphrase', passphrase)
          ..add('iv', iv))
        .toString();
  }
}

class PartialKeyBuilder implements Builder<PartialKey, PartialKeyBuilder> {
  _$PartialKey? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  CountBuilder? _count;
  CountBuilder get count => _$this._count ??= new CountBuilder();
  set count(CountBuilder? count) => _$this._count = count;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _passphrase;
  String? get passphrase => _$this._passphrase;
  set passphrase(String? passphrase) => _$this._passphrase = passphrase;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  PartialKeyBuilder() {
    PartialKey._defaults(this);
  }

  PartialKeyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _id = $v.id;
      _count = $v.count.toBuilder();
      _value = $v.value;
      _passphrase = $v.passphrase;
      _iv = $v.iv;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PartialKey other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PartialKey;
  }

  @override
  void update(void Function(PartialKeyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PartialKey build() => _build();

  _$PartialKey _build() {
    _$PartialKey _$result;
    try {
      _$result = _$v ??
          new _$PartialKey._(
              label: BuiltValueNullFieldError.checkNotNull(
                  label, r'PartialKey', 'label'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'PartialKey', 'id'),
              count: count.build(),
              value: BuiltValueNullFieldError.checkNotNull(
                  value, r'PartialKey', 'value'),
              passphrase: passphrase,
              iv: BuiltValueNullFieldError.checkNotNull(
                  iv, r'PartialKey', 'iv'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'count';
        count.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PartialKey', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
