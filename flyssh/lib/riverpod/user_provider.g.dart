// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      username: json['username'] as String,
      masterKey: json['masterKey'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'masterKey': instance.masterKey,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userNotifierHash() => r'6dd36421e9159a649f78cb7260d7aa90199aec0e';

/// See also [UserNotifier].
@ProviderFor(UserNotifier)
final userNotifierProvider =
    AutoDisposeNotifierProvider<UserNotifier, User?>.internal(
  UserNotifier.new,
  name: r'userNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserNotifier = AutoDisposeNotifier<User?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
