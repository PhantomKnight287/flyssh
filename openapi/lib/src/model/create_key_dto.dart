//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_key_dto.g.dart';

/// CreateKeyDTO
///
/// Properties:
/// * [label] - Label of the key
/// * [value] - Encrypted 'private' key
/// * [passphrase] - Passphrase
/// * [iv] - IV used to encrypt the key
@BuiltValue()
abstract class CreateKeyDTO implements Built<CreateKeyDTO, CreateKeyDTOBuilder> {
  /// Label of the key
  @BuiltValueField(wireName: r'label')
  String get label;

  /// Encrypted 'private' key
  @BuiltValueField(wireName: r'value')
  String get value;

  /// Passphrase
  @BuiltValueField(wireName: r'passphrase')
  String? get passphrase;

  /// IV used to encrypt the key
  @BuiltValueField(wireName: r'iv')
  String get iv;

  CreateKeyDTO._();

  factory CreateKeyDTO([void updates(CreateKeyDTOBuilder b)]) = _$CreateKeyDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateKeyDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateKeyDTO> get serializer => _$CreateKeyDTOSerializer();
}

class _$CreateKeyDTOSerializer implements PrimitiveSerializer<CreateKeyDTO> {
  @override
  final Iterable<Type> types = const [CreateKeyDTO, _$CreateKeyDTO];

  @override
  final String wireName = r'CreateKeyDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateKeyDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    if (object.passphrase != null) {
      yield r'passphrase';
      yield serializers.serialize(
        object.passphrase,
        specifiedType: const FullType(String),
      );
    }
    yield r'iv';
    yield serializers.serialize(
      object.iv,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateKeyDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateKeyDTOBuilder result,
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
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        case r'passphrase':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.passphrase = valueDes;
          break;
        case r'iv':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.iv = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateKeyDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateKeyDTOBuilder();
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

