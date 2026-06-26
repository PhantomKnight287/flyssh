import 'package:flyssh_api/src/model/auth_login_user_request.dart';
import 'package:flyssh_api/src/model/auth_login_user_response.dart';
import 'package:flyssh_api/src/model/auth_recover_request.dart';
import 'package:flyssh_api/src/model/auth_recover_response.dart';
import 'package:flyssh_api/src/model/auth_register_user_request.dart';
import 'package:flyssh_api/src/model/auth_register_user_response.dart';
import 'package:flyssh_api/src/model/auth_setup_recovery_request.dart';
import 'package:flyssh_api/src/model/hosts_create_host_request.dart';
import 'package:flyssh_api/src/model/hosts_host_response.dart';
import 'package:flyssh_api/src/model/hosts_update_host_request.dart';
import 'package:flyssh_api/src/model/keys_create_key_request.dart';
import 'package:flyssh_api/src/model/keys_key_response.dart';
import 'package:flyssh_api/src/model/keys_update_key_request.dart';
import 'package:flyssh_api/src/model/models_error.dart';
import 'package:flyssh_api/src/model/models_generic_response.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'AuthLoginUserRequest':
          return AuthLoginUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthLoginUserResponse':
          return AuthLoginUserResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthRecoverRequest':
          return AuthRecoverRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthRecoverResponse':
          return AuthRecoverResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthRegisterUserRequest':
          return AuthRegisterUserRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthRegisterUserResponse':
          return AuthRegisterUserResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'AuthSetupRecoveryRequest':
          return AuthSetupRecoveryRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HostsCreateHostRequest':
          return HostsCreateHostRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HostsHostResponse':
          return HostsHostResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HostsUpdateHostRequest':
          return HostsUpdateHostRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KeysCreateKeyRequest':
          return KeysCreateKeyRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KeysKeyResponse':
          return KeysKeyResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'KeysUpdateKeyRequest':
          return KeysUpdateKeyRequest.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ModelsError':
          return ModelsError.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ModelsGenericResponse':
          return ModelsGenericResponse.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }