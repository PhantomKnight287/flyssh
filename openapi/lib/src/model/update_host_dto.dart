//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_host_dto.g.dart';

/// UpdateHostDto
///
/// Properties:
/// * [label] 
/// * [hostname] - Encrypted hostname
/// * [username] - Encrypted username
/// * [port] - The port at which sshd is running
/// * [password] - Encrypted password
/// * [keyId] - Id of key, existing or new
@BuiltValue()
abstract class UpdateHostDto implements Built<UpdateHostDto, UpdateHostDtoBuilder> {
  @BuiltValueField(wireName: r'label')
  String? get label;

  /// Encrypted hostname
  @BuiltValueField(wireName: r'hostname')
  String? get hostname;

  /// Encrypted username
  @BuiltValueField(wireName: r'username')
  String? get username;

  /// The port at which sshd is running
  @BuiltValueField(wireName: r'port')
  num? get port;

  /// Encrypted password
  @BuiltValueField(wireName: r'password')
  String? get password;

  /// Id of key, existing or new
  @BuiltValueField(wireName: r'keyId')
  String? get keyId;

  UpdateHostDto._();

  factory UpdateHostDto([void updates(UpdateHostDtoBuilder b)]) = _$UpdateHostDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateHostDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateHostDto> get serializer => _$UpdateHostDtoSerializer();
}

class _$UpdateHostDtoSerializer implements PrimitiveSerializer<UpdateHostDto> {
  @override
  final Iterable<Type> types = const [UpdateHostDto, _$UpdateHostDto];

  @override
  final String wireName = r'UpdateHostDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateHostDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.label != null) {
      yield r'label';
      yield serializers.serialize(
        object.label,
        specifiedType: const FullType(String),
      );
    }
    if (object.hostname != null) {
      yield r'hostname';
      yield serializers.serialize(
        object.hostname,
        specifiedType: const FullType(String),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
        specifiedType: const FullType(String),
      );
    }
    if (object.port != null) {
      yield r'port';
      yield serializers.serialize(
        object.port,
        specifiedType: const FullType(num),
      );
    }
    if (object.password != null) {
      yield r'password';
      yield serializers.serialize(
        object.password,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.keyId != null) {
      yield r'keyId';
      yield serializers.serialize(
        object.keyId,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateHostDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateHostDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.label = valueDes;
          break;
        case r'hostname':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.hostname = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'port':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.port = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.password = valueDes;
          break;
        case r'keyId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.keyId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateHostDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateHostDtoBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

