//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generic_response_dto.g.dart';

/// GenericResponseDto
///
/// Properties:
/// * [id] 
@BuiltValue()
abstract class GenericResponseDto implements Built<GenericResponseDto, GenericResponseDtoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  GenericResponseDto._();

  factory GenericResponseDto([void updates(GenericResponseDtoBuilder b)]) = _$GenericResponseDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenericResponseDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenericResponseDto> get serializer => _$GenericResponseDtoSerializer();
}

class _$GenericResponseDtoSerializer implements PrimitiveSerializer<GenericResponseDto> {
  @override
  final Iterable<Type> types = const [GenericResponseDto, _$GenericResponseDto];

  @override
  final String wireName = r'GenericResponseDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenericResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    GenericResponseDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenericResponseDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenericResponseDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenericResponseDtoBuilder();
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

