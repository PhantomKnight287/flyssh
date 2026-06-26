import 'package:test/test.dart';
import 'package:flyssh_api/flyssh_api.dart';


/// tests for HostsApi
void main() {
  final instance = FlysshApi().getHostsApi();

  group(HostsApi, () {
    // List all hosts
    //
    // Return all SSH hosts belonging to the authenticated user, with keys preloaded.
    //
    //Future<List<HostsHostResponse>> hostsGet(String authorization) async
    test('test hostsGet', () async {
      // TODO
    });

    // Delete a host
    //
    // Delete an SSH host by ID. Must belong to the authenticated user.
    //
    //Future<Map<String, String>> hostsIdDelete(String authorization, int id) async
    test('test hostsIdDelete', () async {
      // TODO
    });

    // Get a single host
    //
    // Return an SSH host by ID with its key preloaded. Must belong to the authenticated user.
    //
    //Future<HostsHostResponse> hostsIdGet(String authorization, int id) async
    test('test hostsIdGet', () async {
      // TODO
    });

    // Update a host
    //
    // Update fields of an existing SSH host. All fields are optional. If keyId is provided, the key must belong to the same user.
    //
    //Future<HostsHostResponse> hostsIdPut(String authorization, int id, HostsUpdateHostRequest hostsUpdateHostRequest) async
    test('test hostsIdPut', () async {
      // TODO
    });

    // Create a new host
    //
    // Store an SSH host configuration. Password is a client-encrypted blob. A key can optionally be attached.
    //
    //Future<HostsHostResponse> hostsPost(String authorization, HostsCreateHostRequest hostsCreateHostRequest) async
    test('test hostsPost', () async {
      // TODO
    });

  });
}
