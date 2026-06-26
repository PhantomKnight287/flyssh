//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_login_user_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthLoginUserRequest {
  /// Returns a new [AuthLoginUserRequest] instance.
  AuthLoginUserRequest({

    required  this.masterKeyHash,

    required  this.password,

    required  this.username,
  });

  @JsonKey(
    
    name: r'masterKeyHash',
    required: true,
    includeIfNull: false,
  )


  final String masterKeyHash;



  @JsonKey(
    
    name: r'password',
    required: true,
    includeIfNull: false,
  )


  final String password;



  @JsonKey(
    
    name: r'username',
    required: true,
    includeIfNull: false,
  )


  final String username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthLoginUserRequest &&
      other.masterKeyHash == masterKeyHash &&
      other.password == password &&
      other.username == username;

    @override
    int get hashCode =>
        masterKeyHash.hashCode +
        password.hashCode +
        username.hashCode;

  factory AuthLoginUserRequest.fromJson(Map<String, dynamic> json) => _$AuthLoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

