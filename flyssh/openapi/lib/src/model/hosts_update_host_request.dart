//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hosts_update_host_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HostsUpdateHostRequest {
  /// Returns a new [HostsUpdateHostRequest] instance.
  HostsUpdateHostRequest({

     this.hostname,

     this.iv,

     this.keyId,

     this.label,

     this.password,

     this.port,

     this.username,
  });

  @JsonKey(
    
    name: r'hostname',
    required: false,
    includeIfNull: false,
  )


  final String? hostname;



  @JsonKey(
    
    name: r'iv',
    required: false,
    includeIfNull: false,
  )


  final String? iv;



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
    
    name: r'username',
    required: false,
    includeIfNull: false,
  )


  final String? username;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HostsUpdateHostRequest &&
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

  factory HostsUpdateHostRequest.fromJson(Map<String, dynamic> json) => _$HostsUpdateHostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$HostsUpdateHostRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

