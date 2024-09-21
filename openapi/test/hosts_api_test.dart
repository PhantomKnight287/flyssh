import 'package:test/test.dart';
import 'package:openapi/openapi.dart';


/// tests for HostsApi
void main() {
  final instance = Openapi().getHostsApi();

  group(HostsApi, () {
    // Create new host
    //
    // Create new host
    //
    //Future<GenericResponseDto> hostsControllerCreate(CreateHostDto createHostDto) async
    test('test hostsControllerCreate', () async {
      // TODO
    });

    // Get all hosts
    //
    // Get all hosts(requires pagination)
    //
    //Future<BuiltList<PartialHost>> hostsControllerFindAll(num page, num limit) async
    test('test hostsControllerFindAll', () async {
      // TODO
    });

    // Get details of a host
    //
    // Get all details of a host
    //
    //Future<Host> hostsControllerFindOne(String id) async
    test('test hostsControllerFindOne', () async {
      // TODO
    });

    // Delete host
    //
    // Delete host
    //
    //Future<GenericResponseDto> hostsControllerRemove(String id) async
    test('test hostsControllerRemove', () async {
      // TODO
    });

    // Update host
    //
    // Update host
    //
    //Future<GenericResponseDto> hostsControllerUpdate(String id, UpdateHostDto updateHostDto) async
    test('test hostsControllerUpdate', () async {
      // TODO
    });

  });
}
