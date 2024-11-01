import 'package:built_collection/built_collection.dart';
import 'package:flyssh/constants/main.dart';
import 'package:openapi/openapi.dart';

final _keysApi = openapi.getKeysApi();

class KeysService {
  static Future<GenericResponseDto> createKey(
    CreateKeyDTO body,
  ) async {
    final req = await _keysApi.keysControllerCreate(
      createKeyDTO: body,
    );
    return req.data!;
  }

  static Future<BuiltList<PartialKey>> getKeys(
    int page, {
    int limit = PAGE_SIZE,
  }) async {
    final req = await _keysApi.keysControllerFindAll(
      page: page,
      limit: limit,
    );
    return req.data!;
  }

  static Future<GenericResponseDto> deleteKey(
    String id,
  ) async {
    final req = await _keysApi.keysControllerDelete(
      id: id,
    );
    return req.data!;
  }

  static Future<GenericResponseDto> updateKey(
    String id,
    UpdateKeyDTO body,
  ) async {
    final req = await _keysApi.keysControllerUpdate(
      id: id,
      updateKeyDTO: body,
    );
    return req.data!;
  }
}
