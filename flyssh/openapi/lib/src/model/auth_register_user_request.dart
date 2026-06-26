//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_register_user_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthRegisterUserRequest {
  /// Returns a new [AuthRegisterUserRequest] instance.
  AuthRegisterUserRequest({

    required  this.masterKeyHash,

    required  this.name,

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
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



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
    bool operator ==(Object other) => identical(this, other) || other is AuthRegisterUserRequest &&
      other.masterKeyHash == masterKeyHash &&
      other.name == name &&
      other.password == password &&
      other.username == username;

    @override
    int get hashCode =>
        masterKeyHash.hashCode +
        name.hashCode +
        password.hashCode +
        username.hashCode;

  factory AuthRegisterUserRequest.fromJson(Map<String, dynamic> json) => _$AuthRegisterUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRegisterUserRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

