//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:flyssh_api/src/model/keys_key_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hosts_host_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HostsHostResponse {
  /// Returns a new [HostsHostResponse] instance.
  HostsHostResponse({

     this.createdAt,

     this.hostname,

     this.id,

     this.iv,

     this.key,

     this.keyId,

     this.label,

     this.password,

     this.port,

     this.updatedAt,

     this.username,
  });

  @JsonKey(
    
    name: r'createdAt',
    required: false,
    includeIfNull: false,
  )


  final String? createdAt;



  @JsonKey(
    
    name: r'hostname',
    required: false,
    includeIfNull: false,
  )


  final String? hostname;



  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final int? id;



  @JsonKey(
    
    name: r'iv',
    required: false,
    includeIfNull: false,
  )


  final String? iv;



  @JsonKey(
    
    name: r'key',
    required: false,
    includeIfNull: false,
  )


  final KeysKeyResponse? key;



  @JsonKey(
    
    name: r'keyId',
    required: false,
    includeIfNull: false,
  )


  final int? keyId;



  @JsonKey(
    
    name: r'label',
    required: false,
    includeIfNull: false,
  )


  final String? label;



  @JsonKey(
    
    name: r'password',
    required: false,
    includeIfNull: false,
  )


  final String? password;



  @JsonKey(
    
    name: r'port',
    required: false,
    includeIfNull: false,
  )


  final int? port;



  @JsonKey(
    
    name: r'updatedAt',
    required: false,
    includeIfNull: false,
  )


  final String? updatedAt;



  @JsonKey(
    
    name: r'username',
    required: false,
    includeIfNull: false,
  )


  final String? username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HostsHostResponse &&
      other.createdAt == createdAt &&
      other.hostname == hostname &&
      other.id == id &&
      other.iv == iv &&
      other.key == key &&
      other.keyId == keyId &&
      other.label == label &&
      other.password == password &&
      other.port == port &&
      other.updatedAt == updatedAt &&
      other.username == username;

    @override
    int get hashCode =>
        createdAt.hashCode +
        hostname.hashCode +
        id.hashCode +
        iv.hashCode +
        key.hashCode +
        keyId.hashCode +
        label.hashCode +
        password.hashCode +
        port.hashCode +
        updatedAt.hashCode +
        username.hashCode;

  factory HostsHostResponse.fromJson(Map<String, dynamic> json) => _$HostsHostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HostsHostResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

