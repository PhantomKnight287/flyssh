//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_login_user_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AuthLoginUserResponse {
  /// Returns a new [AuthLoginUserResponse] instance.
  AuthLoginUserResponse({

     this.expiresAt,

     this.name,

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
    bool operator ==(Object other) => identical(this, other) || other is AuthLoginUserResponse &&
      other.expiresAt == expiresAt &&
      other.name == name &&
      other.token == token &&
      other.username == username;

    @override
    int get hashCode =>
        expiresAt.hashCode +
        name.hashCode +
        token.hashCode +
        username.hashCode;

  factory AuthLoginUserResponse.fromJson(Map<String, dynamic> json) => _$AuthLoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginUserResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

