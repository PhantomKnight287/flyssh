//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_recover_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthRecoverRequest {
  /// Returns a new [AuthRecoverRequest] instance.
  AuthRecoverRequest({

    required  this.password,

    required  this.recoveryKey,

    required  this.username,
  });

  @JsonKey(
    
    name: r'password',
    required: true,
    includeIfNull: false,
  )


  final String password;



  @JsonKey(
    
    name: r'recoveryKey',
    required: true,
    includeIfNull: false,
  )


  final String recoveryKey;



  @JsonKey(
    
    name: r'username',
    required: true,
    includeIfNull: false,
  )


  final String username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthRecoverRequest &&
      other.password == password &&
      other.recoveryKey == recoveryKey &&
      other.username == username;

    @override
    int get hashCode =>
        password.hashCode +
        recoveryKey.hashCode +
        username.hashCode;

  factory AuthRecoverRequest.fromJson(Map<String, dynamic> json) => _$AuthRecoverRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRecoverRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

