//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keys_update_key_request.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class KeysUpdateKeyRequest {
  /// Returns a new [KeysUpdateKeyRequest] instance.
  KeysUpdateKeyRequest({

     this.iv,

     this.label,

     this.passphrase,

     this.value,
  });

  @JsonKey(
    
    name: r'iv',
    required: false,
    includeIfNull: false,
  )


  final String? iv;



  @JsonKey(
    
    name: r'label',
    required: false,
    includeIfNull: false,
  )


  final String? label;



  @JsonKey(
    
    name: r'passphrase',
    required: false,
    includeIfNull: false,
  )


  final String? passphrase;



  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final String? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is KeysUpdateKeyRequest &&
      other.iv == iv &&
      other.label == label &&
      other.passphrase == passphrase &&
      other.value == value;

    @override
    int get hashCode =>
        iv.hashCode +
        label.hashCode +
        passphrase.hashCode +
        value.hashCode;

  factory KeysUpdateKeyRequest.fromJson(Map<String, dynamic> json) => _$KeysUpdateKeyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KeysUpdateKeyRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

