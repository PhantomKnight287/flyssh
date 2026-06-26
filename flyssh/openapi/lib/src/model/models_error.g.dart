// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models_error.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ModelsErrorCWProxy {
  ModelsError errors(Map<String, String>? errors);

  ModelsError message(String? message);

  ModelsError statusCode(int? statusCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModelsError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModelsError(...).copyWith(id: 12, name: "My name")
  /// ````
  ModelsError call({
    Map<String, String>? errors,
    String? message,
    int? statusCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfModelsError.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfModelsError.copyWith.fieldName(...)`
class _$ModelsErrorCWProxyImpl implements _$ModelsErrorCWProxy {
  const _$ModelsErrorCWProxyImpl(this._value);

  final ModelsError _value;

  @override
  ModelsError errors(Map<String, String>? errors) => this(errors: errors);

  @override
  ModelsError message(String? message) => this(message: message);

  @override
  ModelsError statusCode(int? statusCode) => this(statusCode: statusCode);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ModelsError(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ModelsError(...).copyWith(id: 12, name: "My name")
  /// ````
  ModelsError call({
    Object? errors = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? statusCode = const $CopyWithPlaceholder(),
  }) {
    return ModelsError(
      errors: errors == const $CopyWithPlaceholder()
          ? _value.errors
          // ignore: cast_nullable_to_non_nullable
          : errors as Map<String, String>?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      statusCode: statusCode == const $CopyWithPlaceholder()
          ? _value.statusCode
          // ignore: cast_nullable_to_non_nullable
          : statusCode as int?,
    );
  }
}

extension $ModelsErrorCopyWith on ModelsError {
  /// Returns a callable class that can be used as follows: `instanceOfModelsError.copyWith(...)` or like so:`instanceOfModelsError.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ModelsErrorCWProxy get copyWith => _$ModelsErrorCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelsError _$ModelsErrorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ModelsError', json, ($checkedConvert) {
      final val = ModelsError(
        errors: $checkedConvert(
          'errors',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
        ),
        message: $checkedConvert('message', (v) => v as String?),
        statusCode: $checkedConvert('statusCode', (v) => (v as num?)?.toInt()),
      );
      return val;
    });

Map<String, dynamic> _$ModelsErrorToJson(ModelsError instance) =>
    <String, dynamic>{
      'errors': ?instance.errors,
      'message': ?instance.message,
      'statusCode': ?instance.statusCode,
    };
