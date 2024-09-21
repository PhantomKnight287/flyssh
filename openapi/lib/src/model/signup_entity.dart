//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signup_entity.g.dart';

/// SignupEntity
///
/// Properties:
/// * [token] - JWT token which will be used for all other requests
/// * [user] 
/// * [masterkey] 
@BuiltValue()
abstract class SignupEntity implements Built<SignupEntity, SignupEntityBuilder> {
  /// JWT token which will be used for all other requests
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'user')
  UserEntity get user;

  @BuiltValueField(wireName: r'masterkey')
  String get masterkey;

  SignupEntity._();

  factory SignupEntity([void updates(SignupEntityBuilder b)]) = _$SignupEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignupEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignupEntity> get serializer => _$SignupEntitySerializer();
}

class _$SignupEntitySerializer implements PrimitiveSerializer<SignupEntity> {
  @override
  final Iterable<Type> types = const [SignupEntity, _$SignupEntity];

  @override
  final String wireName = r'SignupEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignupEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'user';
    yield serializers.serialize(
      object.user,
      specifiedType: const FullType(UserEntity),
    );
    yield r'masterkey';
    yield serializers.serialize(
      object.masterkey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SignupEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignupEntityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UserEntity),
          ) as UserEntity;
          result.user.replace(valueDes);
          break;
        case r'masterkey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.masterkey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignupEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignupEntityBuilder();
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

