//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_register_user_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthRegisterUserResponse {
  /// Returns a new [AuthRegisterUserResponse] instance.
  AuthRegisterUserResponse({

     this.expiresAt,

     this.name,

     this.recoveryKey,

     this.token,

     this.username,
  });

  @JsonKey(
    
    name: r'expiresAt',
    required: false,
    includeIfNull: false,
  )


  final int? expiresAt;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'recoveryKey',
    required: false,
    includeIfNull: false,
  )


  final String? recoveryKey;



  @JsonKey(
    
    name: r'token',
    required: false,
    includeIfNull: false,
  )


  final String? token;



  @JsonKey(
    
    name: r'username',
    required: false,
    includeIfNull: false,
  )


  final String? username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AuthRegisterUserResponse &&
      other.expiresAt == expiresAt &&
      other.name == name &&
      other.recoveryKey == recoveryKey &&
      other.token == token &&
      other.username == username;

    @override
    int get hashCode =>
        expiresAt.hashCode +
        name.hashCode +
        recoveryKey.hashCode +
        token.hashCode +
        username.hashCode;

  factory AuthRegisterUserResponse.fromJson(Map<String, dynamic> json) => _$AuthRegisterUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRegisterUserResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

