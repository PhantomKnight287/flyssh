import 'package:flyssh/constants/main.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';

final _hostsApi = openapi.getHostsApi();

class HostsService {
  static Future<BuiltList<PartialHost>> getHosts(
    int page, {
    int limit = PAGE_SIZE,
  }) async {
    final req = await _hostsApi.hostsControllerFindAll(
      page: page,
      limit: limit,
    );
    return req.data!;
  }

  static Future<GenericResponseDto> createHost(
    CreateHostDto body,
  ) async {
    final req = await _hostsApi.hostsControllerCreate(
      createHostDto: body,
    );
    return req.data!;
  }
}
