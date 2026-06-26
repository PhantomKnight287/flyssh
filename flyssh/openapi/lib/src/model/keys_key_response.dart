//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keys_key_response.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class KeysKeyResponse {
  /// Returns a new [KeysKeyResponse] instance.
  KeysKeyResponse({

     this.createdAt,

     this.id,

     this.iv,

     this.label,

     this.passphrase,

     this.updatedAt,

     this.value,
  });

  @JsonKey(
    
    name: r'createdAt',
    required: false,
    includeIfNull: false,
  )


  final String? createdAt;



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
    
    name: r'updatedAt',
    required: false,
    includeIfNull: false,
  )


  final String? updatedAt;



  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final String? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is KeysKeyResponse &&
      other.createdAt == createdAt &&
      other.id == id &&
      other.iv == iv &&
      other.label == label &&
      other.passphrase == passphrase &&
      other.updatedAt == updatedAt &&
      other.value == value;

    @override
    int get hashCode =>
        createdAt.hashCode +
        id.hashCode +
        iv.hashCode +
        label.hashCode +
        passphrase.hashCode +
        updatedAt.hashCode +
        value.hashCode;

  factory KeysKeyResponse.fromJson(Map<String, dynamic> json) => _$KeysKeyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KeysKeyResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

