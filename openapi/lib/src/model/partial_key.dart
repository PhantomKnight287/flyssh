//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/count.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'partial_key.g.dart';

/// PartialKey
///
/// Properties:
/// * [label] 
/// * [id] 
/// * [count] 
@BuiltValue()
abstract class PartialKey implements Built<PartialKey, PartialKeyBuilder> {
  @BuiltValueField(wireName: r'label')
  String get label;

  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'_count')
  Count get count;

  PartialKey._();

  factory PartialKey([void updates(PartialKeyBuilder b)]) = _$PartialKey;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PartialKeyBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PartialKey> get serializer => _$PartialKeySerializer();
}

class _$PartialKeySerializer implements PrimitiveSerializer<PartialKey> {
  @override
  final Iterable<Type> types = const [PartialKey, _$PartialKey];

  @override
  final String wireName = r'PartialKey';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PartialKey object, {
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
    yield r'_count';
    yield serializers.serialize(
      object.count,
      specifiedType: const FullType(Count),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PartialKey object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PartialKeyBuilder result,
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
        case r'_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Count),
          ) as Count;
          result.count.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PartialKey deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PartialKeyBuilder();
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

