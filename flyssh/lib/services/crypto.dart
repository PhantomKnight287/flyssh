import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:pointycastle/export.dart';

@injectable
class CryptoService {
  String generateMasterKey() {
    final random = Random.secure();
    final bytes = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      bytes[i] = random.nextInt(256);
    }
    return base64Url.encode(bytes);
  }

  String deriveAuthKey(String masterKey, String username) {
    final salt = utf8.encode(username);
    final keyBytes = base64Url.decode(masterKey);

    final params = Pbkdf2Parameters(
      Uint8List.fromList(salt),
      100000,
      32,
    );

    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
      ..init(params);

    final derived = pbkdf2.process(Uint8List.fromList(keyBytes));
    return base64Url.encode(derived);
  }

  ({String ciphertext, String iv}) encrypt(String plaintext, String keyBase64) {
    final key = base64Url.decode(keyBase64);
    final random = Random.secure();
    final ivBytes = Uint8List(12);
    for (var i = 0; i < 12; i++) {
      ivBytes[i] = random.nextInt(256);
    }

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true,
        AEADParameters(
          KeyParameter(Uint8List.fromList(key)),
          128,
          ivBytes,
          Uint8List(0),
        ),
      );

    final plaintextBytes = utf8.encode(plaintext);
    final output = cipher.process(Uint8List.fromList(plaintextBytes));

    return (
      ciphertext: base64.encode(output),
      iv: base64.encode(ivBytes),
    );
  }

  String encryptWithIv(String plaintext, String keyBase64, String ivBase64) {
    final key = base64Url.decode(keyBase64);
    final ivBytes = base64.decode(ivBase64);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true,
        AEADParameters(
          KeyParameter(Uint8List.fromList(key)),
          128,
          Uint8List.fromList(ivBytes),
          Uint8List(0),
        ),
      );

    final plaintextBytes = utf8.encode(plaintext);
    final output = cipher.process(Uint8List.fromList(plaintextBytes));
    return base64.encode(output);
  }

  String decrypt(String ciphertextBase64, String ivBase64, String keyBase64) {
    final key = base64Url.decode(keyBase64);
    final iv = base64.decode(ivBase64);
    final ciphertext = base64.decode(ciphertextBase64);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        false,
        AEADParameters(
          KeyParameter(Uint8List.fromList(key)),
          128,
          Uint8List.fromList(iv),
          Uint8List(0),
        ),
      );

    final output = cipher.process(Uint8List.fromList(ciphertext));
    return utf8.decode(output);
  }
}
