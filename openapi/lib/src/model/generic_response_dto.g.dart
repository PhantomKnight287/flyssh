// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenericResponseDto extends GenericResponseDto {
  @override
  final String id;

  factory _$GenericResponseDto(
          [void Function(GenericResponseDtoBuilder)? updates]) =>
      (new GenericResponseDtoBuilder()..update(updates))._build();

  _$GenericResponseDto._({required this.id}) : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'GenericResponseDto', 'id');
  }

  @override
  GenericResponseDto rebuild(
          void Function(GenericResponseDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenericResponseDtoBuilder toBuilder() =>
      new GenericResponseDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenericResponseDto && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenericResponseDto')..add('id', id))
        .toString();
  }
}

class GenericResponseDtoBuilder
    implements Builder<GenericResponseDto, GenericResponseDtoBuilder> {
  _$GenericResponseDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GenericResponseDtoBuilder() {
    GenericResponseDto._defaults(this);
  }

  GenericResponseDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenericResponseDto other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GenericResponseDto;
  }

  @override
  void update(void Function(GenericResponseDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenericResponseDto build() => _build();

  _$GenericResponseDto _build() {
    final _$result = _$v ??
        new _$GenericResponseDto._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GenericResponseDto', 'id'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
