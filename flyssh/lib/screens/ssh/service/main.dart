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

    final decryptedPassword = encryptedHostData.password != null
        ? encryter.decrypt64(
            encryptedHostData.password!,
            iv: encrypt.IV.fromBase64(
              encryptedHostData.iv,
            ),
          )
        : null;
    String? decryptedKey;
    String? decryptedPassphrase;
    if (encryptedHostData.key != null) {
      decryptedKey = encryter.decrypt64(
        encryptedHostData.key!.value,
        iv: encrypt.IV.fromBase64(
          encryptedHostData.key!.iv,
        ),
      );
      if (encryptedHostData.key!.passphrase != null) {
        decryptedPassphrase = encryter.decrypt64(
          encryptedHostData.key!.passphrase!,
          iv: encrypt.IV.fromBase64(
            encryptedHostData.key!.iv,
          ),
        );
      }
    }

    return Host(
      (b) {
        final key = encryptedHostData.key == null
            ? null
            : (KeyEntityBuilder()
              ..id = encryptedHostData.key!.id
              ..label = encryptedHostData.key!.label
              ..value = decryptedKey!
              ..passphrase = decryptedPassphrase
              ..iv = encryptedHostData.key!.iv
              ..build());

        b
          ..id = encryptedHostData.id
          ..label = encryptedHostData.label
          ..password = decryptedPassword
          ..port = encryptedHostData.port
          ..username = encryptedHostData.username
          ..iv = encryptedHostData.iv
          ..hostname = encryptedHostData.hostname
          ..key = encryptedHostData.key == null ? null : key
          ..build();
      },
    );
  }
}
