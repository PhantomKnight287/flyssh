// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_key_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateKeyDTO extends CreateKeyDTO {
  @override
  final String label;
  @override
  final String value;
  @override
  final String? passphrase;
  @override
  final String iv;

  factory _$CreateKeyDTO([void Function(CreateKeyDTOBuilder)? updates]) =>
      (new CreateKeyDTOBuilder()..update(updates))._build();

  _$CreateKeyDTO._(
      {required this.label,
      required this.value,
      this.passphrase,
      required this.iv})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(label, r'CreateKeyDTO', 'label');
    BuiltValueNullFieldError.checkNotNull(value, r'CreateKeyDTO', 'value');
    BuiltValueNullFieldError.checkNotNull(iv, r'CreateKeyDTO', 'iv');
  }

  @override
  CreateKeyDTO rebuild(void Function(CreateKeyDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateKeyDTOBuilder toBuilder() => new CreateKeyDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateKeyDTO &&
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
    return (newBuiltValueToStringHelper(r'CreateKeyDTO')
          ..add('label', label)
          ..add('value', value)
          ..add('passphrase', passphrase)
          ..add('iv', iv))
        .toString();
  }
}

class CreateKeyDTOBuilder
    implements Builder<CreateKeyDTO, CreateKeyDTOBuilder> {
  _$CreateKeyDTO? _$v;

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

  CreateKeyDTOBuilder() {
    CreateKeyDTO._defaults(this);
  }

  CreateKeyDTOBuilder get _$this {
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
  void replace(CreateKeyDTO other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CreateKeyDTO;
  }

  @override
  void update(void Function(CreateKeyDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateKeyDTO build() => _build();

  _$CreateKeyDTO _build() {
    final _$result = _$v ??
        new _$CreateKeyDTO._(
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'CreateKeyDTO', 'label'),
            value: BuiltValueNullFieldError.checkNotNull(
                value, r'CreateKeyDTO', 'value'),
            passphrase: passphrase,
            iv: BuiltValueNullFieldError.checkNotNull(
                iv, r'CreateKeyDTO', 'iv'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
