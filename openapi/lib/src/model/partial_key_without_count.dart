//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'partial_key_without_count.g.dart';

/// PartialKeyWithoutCount
///
/// Properties:
/// * [label] 
/// * [id] 
@BuiltValue()
abstract class PartialKeyWithoutCount implements Built<PartialKeyWithoutCount, PartialKeyWithoutCountBuilder> {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'id')
  String get id;

  PartialKeyWithoutCount._();

  factory PartialKeyWithoutCount([void updates(PartialKeyWithoutCountBuilder b)]) = _$PartialKeyWithoutCount;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PartialKeyWithoutCountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PartialKeyWithoutCount> get serializer => _$PartialKeyWithoutCountSerializer();
}

class _$PartialKeyWithoutCountSerializer implements PrimitiveSerializer<PartialKeyWithoutCount> {
  @override
  final Iterable<Type> types = const [PartialKeyWithoutCount, _$PartialKeyWithoutCount];

  @override
  final String wireName = r'PartialKeyWithoutCount';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PartialKeyWithoutCount object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'label';
    yield serializers.serialize(
      object.label,
      specifiedType: const FullType(String),
    );
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PartialKeyWithoutCount object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PartialKeyWithoutCountBuilder result,
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
  PartialKeyWithoutCount deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PartialKeyWithoutCountBuilder();
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

