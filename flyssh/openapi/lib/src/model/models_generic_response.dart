//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models_generic_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ModelsGenericResponse {
  /// Returns a new [ModelsGenericResponse] instance.
  ModelsGenericResponse({

     this.message,
  });

  @JsonKey(
    
    name: r'message',
    required: false,
    includeIfNull: false,
  )


  final String? message;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ModelsGenericResponse &&
      other.message == message;

    @override
    int get hashCode =>
        message.hashCode;

  factory ModelsGenericResponse.fromJson(Map<String, dynamic> json) => _$ModelsGenericResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ModelsGenericResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

