//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_recover_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthRecoverResponse {
  /// Returns a new [AuthRecoverResponse] instance.
  AuthRecoverResponse({

     this.encryptedMasterKey,
  });

  @JsonKey(
    
    name: r'encryptedMasterKey',
    required: false,
    includeIfNull: false,
  )


  final String? encryptedMasterKey;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthRecoverResponse &&
      other.encryptedMasterKey == encryptedMasterKey;

    @override
    int get hashCode =>
        encryptedMasterKey.hashCode;

  factory AuthRecoverResponse.fromJson(Map<String, dynamic> json) => _$AuthRecoverResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRecoverResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

