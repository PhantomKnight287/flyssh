//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models_error.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ModelsError {
  /// Returns a new [ModelsError] instance.
  ModelsError({

     this.errors,

     this.message,

     this.statusCode,
  });

  @JsonKey(
    
    name: r'errors',
    required: false,
    includeIfNull: false,
  )


  final Map<String, String>? errors;



  @JsonKey(
    
    name: r'message',
    required: false,
    includeIfNull: false,
  )


  final String? message;



  @JsonKey(
    
    name: r'statusCode',
    required: false,
    includeIfNull: false,
  )


  final int? statusCode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ModelsError &&
      other.errors == errors &&
      other.message == message &&
      other.statusCode == statusCode;

    @override
    int get hashCode =>
        errors.hashCode +
        message.hashCode +
        statusCode.hashCode;

  factory ModelsError.fromJson(Map<String, dynamic> json) => _$ModelsErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ModelsErrorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

