// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_key_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateKeyDTO extends UpdateKeyDTO {
  @override
  final String? label;
  @override
  final String? value;
  @override
  final String? passphrase;
  @override
  final String? iv;

  factory _$UpdateKeyDTO([void Function(UpdateKeyDTOBuilder)? updates]) =>
      (new UpdateKeyDTOBuilder()..update(updates))._build();

  _$UpdateKeyDTO._({this.label, this.value, this.passphrase, this.iv})
      : super._();

  @override
  UpdateKeyDTO rebuild(void Function(UpdateKeyDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateKeyDTOBuilder toBuilder() => new UpdateKeyDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateKeyDTO &&
        label == other.label &&
        value == other.value &&
        passphrase == other.passphrase &&
        iv == other.iv;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, passphrase.hashCode);
    _$hash = $jc(_$hash, iv.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateKeyDTO')
          ..add('label', label)
          ..add('value', value)
          ..add('passphrase', passphrase)
          ..add('iv', iv))
        .toString();
  }
}

class UpdateKeyDTOBuilder
    implements Builder<UpdateKeyDTO, UpdateKeyDTOBuilder> {
  _$UpdateKeyDTO? _$v;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _passphrase;
  String? get passphrase => _$this._passphrase;
  set passphrase(String? passphrase) => _$this._passphrase = passphrase;

  String? _iv;
  String? get iv => _$this._iv;
  set iv(String? iv) => _$this._iv = iv;

  UpdateKeyDTOBuilder() {
    UpdateKeyDTO._defaults(this);
  }

  UpdateKeyDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _label = $v.label;
      _value = $v.value;
      _passphrase = $v.passphrase;
      _iv = $v.iv;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateKeyDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UpdateKeyDTO;
  }

  @override
  void update(void Function(UpdateKeyDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateKeyDTO build() => _build();

  _$UpdateKeyDTO _build() {
    final _$result = _$v ??
        new _$UpdateKeyDTO._(
            label: label, value: value, passphrase: passphrase, iv: iv);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
