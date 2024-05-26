import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'dart:convert';

class EncryptionService {
  // The secret key and IV (initialization vector) should be kept secure
  static final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1'); // 32 chars
  static final iv = encrypt.IV.fromLength(16);

  // Encrypt function
  static String encryptPassword(String password) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(password, iv: iv);
    return encrypted.base64;  // Return the encrypted string in base64 format
  }

  // Decrypt function
  static String decryptPassword(String encryptedPassword) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedPassword), iv: iv);
    return decrypted;
  }
}
