// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_key_without_count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PartialKeyWithoutCount extends PartialKeyWithoutCount {
  @override
  final String label;
  @override
  final String id;

  factory _$PartialKeyWithoutCount(
          [void Function(PartialKeyWithoutCountBuilder)? updates]) =>
      (new PartialKeyWithoutCountBuilder()..update(updates))._build();

  _$PartialKeyWithoutCount._({required this.label, required this.id})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        label, r'PartialKeyWithoutCount', 'label');
    BuiltValueNullFieldError.checkNotNull(id, r'PartialKeyWithoutCount', 'id');
  }

  @override
  PartialKeyWithoutCount rebuild(
          void Function(PartialKeyWithoutCountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PartialKeyWithoutCountBuilder toBuilder() =>
      new PartialKeyWithoutCountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PartialKeyWithoutCount &&
        label == other.label &&
        id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PartialKeyWithoutCount')
          ..add('label', label)
          ..add('id', id))
        .toString();
  }
}

class PartialKeyWithoutCountBuilder
    implements Builder<PartialKeyWithoutCount, PartialKeyWithoutCountBuilder> {
  _$PartialKeyWithoutCount? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  PartialKeyWithoutCountBuilder() {
    PartialKeyWithoutCount._defaults(this);
  }

  PartialKeyWithoutCountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PartialKeyWithoutCount other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PartialKeyWithoutCount;
  }

  @override
  void update(void Function(PartialKeyWithoutCountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PartialKeyWithoutCount build() => _build();

  _$PartialKeyWithoutCount _build() {
    final _$result = _$v ??
        new _$PartialKeyWithoutCount._(
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'PartialKeyWithoutCount', 'label'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'PartialKeyWithoutCount', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
