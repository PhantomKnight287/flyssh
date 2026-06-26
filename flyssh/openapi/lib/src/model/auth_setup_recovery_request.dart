//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_setup_recovery_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthSetupRecoveryRequest {
  /// Returns a new [AuthSetupRecoveryRequest] instance.
  AuthSetupRecoveryRequest({

    required  this.encryptedMasterKey,
  });

  @JsonKey(
    
    name: r'encryptedMasterKey',
    required: true,
    includeIfNull: false,
  )


  final String encryptedMasterKey;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthSetupRecoveryRequest &&
      other.encryptedMasterKey == encryptedMasterKey;

    @override
    int get hashCode =>
        encryptedMasterKey.hashCode;

  factory AuthSetupRecoveryRequest.fromJson(Map<String, dynamic> json) => _$AuthSetupRecoveryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthSetupRecoveryRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

