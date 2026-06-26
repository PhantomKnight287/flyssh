import 'package:test/test.dart';
import 'package:flyssh_api/flyssh_api.dart';


/// tests for KeysApi
void main() {
  final instance = FlysshApi().getKeysApi();

  group(KeysApi, () {
    // List all SSH keys
    //
    // Return all SSH keys belonging to the authenticated user.
    //
    //Future<List<KeysKeyResponse>> keysGet(String authorization) async
    test('test keysGet', () async {
      // TODO
    });

    // Delete an SSH key
    //
    // Delete an SSH key by ID. Associated hosts will have their keyId set to null.
    //
    //Future<Map<String, String>> keysIdDelete(String authorization, int id) async
    test('test keysIdDelete', () async {
      // TODO
    });

    // Get a single SSH key
    //
    // Return an SSH key by ID. Must belong to the authenticated user.
    //
    //Future<KeysKeyResponse> keysIdGet(String authorization, int id) async
    test('test keysIdGet', () async {
      // TODO
    });

    // Update an SSH key
    //
    // Update fields of an existing SSH key. All fields are optional.
    //
    //Future<KeysKeyResponse> keysIdPut(String authorization, int id, KeysUpdateKeyRequest keysUpdateKeyRequest) async
    test('test keysIdPut', () async {
      // TODO
    });

    // Create a new SSH key
    //
    // Store a client-encrypted SSH key. The value and optional passphrase are opaque encrypted blobs.
    //
    //Future<KeysKeyResponse> keysPost(String authorization, KeysCreateKeyRequest keysCreateKeyRequest) async
    test('test keysPost', () async {
      // TODO
    });

  });
}
