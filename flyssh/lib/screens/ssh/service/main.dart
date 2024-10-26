import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flyssh/constants/main.dart';
import 'package:openapi/openapi.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

final _hostApi = openapi.getHostsApi();

class HostService {
  static Future<Host> getHostInfo(
    String id,
  ) async {
    final req = await _hostApi.hostsControllerFindOne(
      id: id,
    );
    final encryptedHostData = req.data!;
    if (encryptedHostData.password == null) return encryptedHostData;
    const storage = FlutterSecureStorage();

    final encryter = encrypt.Encrypter(
      encrypt.AES(
        encrypt.Key.fromBase64(
          (await storage.read(
            key: MASTER_KEY_KEY,
          ))!,
        ),
        padding: null,
      ),
    );

    final decryptedPassword = encryter.decrypt64(
      encryptedHostData.password!,
      iv: encrypt.IV.fromBase64(
        encryptedHostData.iv,
      ),
    );
    return Host(
      (b) {
        b
          ..id = encryptedHostData.id
          ..label = encryptedHostData.label
          ..password = decryptedPassword.trim()
          ..port = encryptedHostData.port
          ..username = encryptedHostData.username
          ..iv = encryptedHostData.iv
          ..hostname = encryptedHostData.hostname
          ..build();
      },
    );
  }
}
