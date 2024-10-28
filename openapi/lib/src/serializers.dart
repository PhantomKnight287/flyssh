//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:openapi/src/date_serializer.dart';
import 'package:openapi/src/model/date.dart';

import 'package:openapi/src/model/count.dart';
import 'package:openapi/src/model/create_host_dto.dart';
import 'package:openapi/src/model/create_key_dto.dart';
import 'package:openapi/src/model/generic_error_entity.dart';
import 'package:openapi/src/model/generic_response_dto.dart';
import 'package:openapi/src/model/host.dart';
import 'package:openapi/src/model/key_entity.dart';
import 'package:openapi/src/model/login_dto.dart';
import 'package:openapi/src/model/login_entity.dart';
import 'package:openapi/src/model/partial_host.dart';
import 'package:openapi/src/model/partial_key.dart';
import 'package:openapi/src/model/partial_key_without_count.dart';
import 'package:openapi/src/model/signup_dto.dart';
import 'package:openapi/src/model/signup_entity.dart';
import 'package:openapi/src/model/update_host_dto.dart';
import 'package:openapi/src/model/user_entity.dart';

part 'serializers.g.dart';

@SerializersFor([
  Count,
  CreateHostDto,
  CreateKeyDTO,
  GenericErrorEntity,
  GenericResponseDto,
  Host,
  KeyEntity,
  LoginDTO,
  LoginEntity,
  PartialHost,
  PartialKey,
  PartialKeyWithoutCount,
  SignupDTO,
  SignupEntity,
  UpdateHostDto,
  UserEntity,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PartialHost)]),
        () => ListBuilder<PartialHost>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(PartialKey)]),
        () => ListBuilder<PartialKey>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
