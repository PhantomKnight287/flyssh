// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_generic_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ModelsGenericResponseCWProxy {
  ModelsGenericResponse message(String? message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModelsGenericResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModelsGenericResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ModelsGenericResponse call({String? message});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfModelsGenericResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfModelsGenericResponse.copyWith.fieldName(...)`
class _$ModelsGenericResponseCWProxyImpl
    implements _$ModelsGenericResponseCWProxy {
  const _$ModelsGenericResponseCWProxyImpl(this._value);

  final ModelsGenericResponse _value;

  @override
  ModelsGenericResponse message(String? message) => this(message: message);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModelsGenericResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModelsGenericResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ModelsGenericResponse call({Object? message = const $CopyWithPlaceholder()}) {
    return ModelsGenericResponse(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $ModelsGenericResponseCopyWith on ModelsGenericResponse {
  /// Returns a callable class that can be used as follows: `instanceOfModelsGenericResponse.copyWith(...)` or like so:`instanceOfModelsGenericResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ModelsGenericResponseCWProxy get copyWith =>
      _$ModelsGenericResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelsGenericResponse _$ModelsGenericResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ModelsGenericResponse', json, ($checkedConvert) {
  final val = ModelsGenericResponse(
    message: $checkedConvert('message', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ModelsGenericResponseToJson(
  ModelsGenericResponse instance,
) => <String, dynamic>{'message': ?instance.message};
