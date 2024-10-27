//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'count.g.dart';

/// Count
///
/// Properties:
/// * [hosts] - No of hosts using this key
@BuiltValue()
abstract class Count implements Built<Count, CountBuilder> {
  /// No of hosts using this key
  @BuiltValueField(wireName: r'hosts')
  num get hosts;

  Count._();

  factory Count([void updates(CountBuilder b)]) = _$Count;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CountBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Count> get serializer => _$CountSerializer();
}

class _$CountSerializer implements PrimitiveSerializer<Count> {
  @override
  final Iterable<Type> types = const [Count, _$Count];

  @override
  final String wireName = r'Count';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Count object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'hosts';
    yield serializers.serialize(
      object.hosts,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Count object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CountBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hosts':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.hosts = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Count deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CountBuilder();
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

