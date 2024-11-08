//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:openapi/src/model/user_entity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'login_entity.g.dart';

/// LoginEntity
///
/// Properties:
/// * [token] - JWT token which will be used for all other requests
/// * [user] 
@BuiltValue()
abstract class LoginEntity implements Built<LoginEntity, LoginEntityBuilder> {
  /// JWT token which will be used for all other requests
  @BuiltValueField(wireName: r'token')
  String get token;

  @BuiltValueField(wireName: r'user')
  UserEntity get user;

  LoginEntity._();

  factory LoginEntity([void updates(LoginEntityBuilder b)]) = _$LoginEntity;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(LoginEntityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<LoginEntity> get serializer => _$LoginEntitySerializer();
}

class _$LoginEntitySerializer implements PrimitiveSerializer<LoginEntity> {
  @override
  final Iterable<Type> types = const [LoginEntity, _$LoginEntity];

  @override
  final String wireName = r'LoginEntity';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    LoginEntity object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    LoginEntity object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required LoginEntityBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  LoginEntity deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = LoginEntityBuilder();
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

