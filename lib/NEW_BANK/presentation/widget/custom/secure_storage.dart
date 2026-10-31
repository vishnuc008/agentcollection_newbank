import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:agentcollection_newbank/NEW_BANK/presentation/widget/custom/custom_print.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:get_storage/get_storage.dart';

class SecureStorage {
  static final box = GetStorage();
  static final key = encrypt.Key.fromUtf8('a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6');

  static Uint8List generateRandomIv() {
    final random = Random.secure();
    return Uint8List.fromList(
      List.generate(16, (index) => random.nextInt(256)),
    );
  }

  static String encryptData(String value) {
    final iv = generateRandomIv();
    final encrypter = encrypt.Encrypter(
      encrypt.AES(key, mode: encrypt.AESMode.cbc),
    );
    final encrypted = encrypter.encrypt(value, iv: encrypt.IV(iv));
    final combinedData = iv + encrypted.bytes;
    encryptionPrint("--------$value encrypted successFully-----");
    return base64.encode(combinedData);
  }

  static String decryptData(String encryptedValue) {
    decryptionPrint("--------$encryptedValue decrypted started-----");
    try {
      final combinedData = base64.decode(encryptedValue);
      if (combinedData.length < 16) {
        throw const FormatException("Invalid combined data length");
      }
      final iv = encrypt.IV(combinedData.sublist(0, 16));
      final encryptedData = combinedData.sublist(16);
      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc),
      );
      final decrypted = encrypter.decrypt64(
        base64.encode(encryptedData),
        iv: iv,
      );

      decryptionPrint("--------$encryptedValue decrypted successFully-----");
      return decrypted;
    } catch (e) {
      retrieveDataErrorPrint("Decryption error: $e");
      return "Error during decryption";
    }
  }

  static Future<void> write(String key, dynamic value) async {
    String stringedValue = value.toString();
    final encryptedValue = encryptData(stringedValue);
    await box.write(key, encryptedValue);
    storeDataPrint("$value writed SuccessFully");
  }

  static String? read(String key) {
    final encryptedvalue = box.read(key);
    if (encryptedvalue == null) {
      retrieveDataErrorPrint("--------Data Stored in $key is Null------");
      return null;
    } else {
      retrieveDataPrint("----Data Stored in $key Retrieved SuccessFully-----");
      return decryptData(encryptedvalue);
    }
  }
  static Future<void> delete(String key) async {
    await box.remove(key);
    storeDataPrint("$key deleted successfully");
  }

}

