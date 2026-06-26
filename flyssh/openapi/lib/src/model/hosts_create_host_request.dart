//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hosts_create_host_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HostsCreateHostRequest {
  /// Returns a new [HostsCreateHostRequest] instance.
  HostsCreateHostRequest({

    required  this.hostname,

    required  this.iv,

     this.keyId,

    required  this.label,

     this.password,

     this.port,

    required  this.username,
  });

  @JsonKey(
    
    name: r'hostname',
    required: true,
    includeIfNull: false,
  )


  final String hostname;



  @JsonKey(
    
    name: r'iv',
    required: true,
    includeIfNull: false,
  )


  final String iv;



  @JsonKey(
    
    name: r'keyId',
    required: false,
    includeIfNull: false,
  )


  final int? keyId;



  @JsonKey(
    
    name: r'label',
    required: true,
    includeIfNull: false,
  )


  final String label;



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
    
    name: r'username',
    required: true,
    includeIfNull: false,
  )


  final String username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HostsCreateHostRequest &&
      other.hostname == hostname &&
      other.iv == iv &&
      other.keyId == keyId &&
      other.label == label &&
      other.password == password &&
      other.port == port &&
      other.username == username;

    @override
    int get hashCode =>
        hostname.hashCode +
        iv.hashCode +
        keyId.hashCode +
        label.hashCode +
        password.hashCode +
        port.hashCode +
        username.hashCode;

  factory HostsCreateHostRequest.fromJson(Map<String, dynamic> json) => _$HostsCreateHostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HostsCreateHostRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

