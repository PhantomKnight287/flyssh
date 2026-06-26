import 'package:dio/dio.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/services/crypto.dart';
import 'package:flyssh/services/master_key.dart';
import 'package:flyssh/utils/error.dart';
import 'package:flyssh_api/flyssh_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class HostService {
  final _api = openapi.getHostsApi();
  final CryptoService cryptoService;
  final MasterKeyService masterKeyService;

  HostService(this.cryptoService, this.masterKeyService);

  Future<List<HostsHostResponse>> getHosts() async {
    try {
      final req = await _api.hostsGet(authorization: '');
      return req.data ?? [];
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<HostsHostResponse> getHost(String id) async {
    try {
      final req = await _api.hostsIdGet(authorization: '', id: int.parse(id));
      final res = req.data;
      if (res == null) throw Exception('Host not found');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<HostsHostResponse> createHost({
    required String label,
    required String hostname,
    required String username,
    int? port,
    String? password,
    int? keyId,
  }) async {
    try {
      final masterKey = await masterKeyService.getMasterKey();
      String iv = '';
      String? encryptedPassword;

      if (password != null && password.isNotEmpty && masterKey != null) {
        final encrypted = cryptoService.encrypt(password, masterKey);
        encryptedPassword = encrypted.ciphertext;
        iv = encrypted.iv;
      } else if (masterKey != null) {
        final dummyEncrypt = cryptoService.encrypt('', masterKey);
        iv = dummyEncrypt.iv;
      }

      final req = await _api.hostsPost(
        authorization: '',
        hostsCreateHostRequest: HostsCreateHostRequest(
          label: label,
          hostname: hostname,
          username: username,
          iv: iv,
          port: port ?? 22,
          password: encryptedPassword,
          keyId: keyId,
        ),
      );
      final res = req.data;
      if (res == null) throw Exception('Failed to create host');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<HostsHostResponse> updateHost({
    required String id,
    String? label,
    String? hostname,
    String? username,
    int? port,
    String? password,
    int? keyId,
  }) async {
    try {
      final masterKey = await masterKeyService.getMasterKey();
      String? iv;
      String? encryptedPassword;

      if (password != null && password.isNotEmpty && masterKey != null) {
        final encrypted = cryptoService.encrypt(password, masterKey);
        encryptedPassword = encrypted.ciphertext;
        iv = encrypted.iv;
      }

      final req = await _api.hostsIdPut(
        authorization: '',
        id: int.parse(id),
        hostsUpdateHostRequest: HostsUpdateHostRequest(
          label: label,
          hostname: hostname,
          username: username,
          port: port,
          password: encryptedPassword,
          keyId: keyId,
          iv: iv,
        ),
      );
      final res = req.data;
      if (res == null) throw Exception('Failed to update host');
      return res;
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<void> deleteHost(String id) async {
    try {
      await _api.hostsIdDelete(authorization: '', id: int.parse(id));
    } catch (e) {
      if (e is DioException) {
        throw Exception(ApiResponse.toHumanMessage(e));
      }
      rethrow;
    }
  }

  Future<void> updateHostOs({
    required String id,
    required String osId,
    required String osName,
    String? osVersion,
  }) async {
    try {
      await dio.patch(
        '/hosts/$id/os',
        data: {
          'osId': osId,
          'osName': osName,
          if (osVersion != null) 'osVersion': osVersion,
        },
      );
    } catch (_) {
      // Best-effort, don't throw on failure
    }
  }

  Future<String?> decryptPasswordAsync(
      String? encryptedPassword, String? iv) async {
    if (encryptedPassword == null ||
        encryptedPassword.isEmpty ||
        iv == null ||
        iv.isEmpty) {
      return null;
    }
    try {
      final masterKey = await masterKeyService.getMasterKey();
      if (masterKey == null) return null;
      return cryptoService.decrypt(encryptedPassword, iv, masterKey);
    } catch (_) {
      return null;
    }
  }
}
