import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';

  SecureStorage._internal();

  factory SecureStorage() => _instance;

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      log('SecureStorage: Data stored successfully for key: $key');
    } catch (e) {
      log('SecureStorage: Error writing data for key: $key, Error: $e');
      rethrow;
    }
  }

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value != null) {
        log('SecureStorage: Data retrieved for key: $key');
      } else {
        log('SecureStorage: No data found for key: $key');
      }
      return value;
    } catch (e) {
      log('SecureStorage: Error reading data for key: $key, Error: $e');
      return null;
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      log('SecureStorage: Data deleted for key: $key');
    } catch (e) {
      log('SecureStorage: Error deleting data for key: $key, Error: $e');
      rethrow;
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      log('SecureStorage: All data cleared from secure storage');
    } catch (e) {
      log('SecureStorage: Error clearing all data, Error: $e');
      rethrow;
    }
  }

  Future<String?> getAccessToken() async {
    return await read(_accessTokenKey);
  }

  Future<void> clearAccessToken() async {
    await delete(_accessTokenKey);
  }

  Future<void> saveAccessToken(String token) async {
    await write(_accessTokenKey, token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refreshToken', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await read(_refreshTokenKey);
  }

  Future<void> clearRefreshToken() async {
    await delete(_refreshTokenKey);
  }

  Future<void> saveUserId(String userId) async {
    await write(_userIdKey, userId);
  }

  Future<String?> getUserId() async {
    return await read(_userIdKey);
  }

  Future<void> clearUserId() async {
    await delete(_userIdKey);
  }

  Future<bool> hasToken() async {
    final token = await getAccessToken();
    return token != null;
  }

  Future<bool> isStorageEmpty() async {
    try {
      final allValues = await _storage.readAll();
      return allValues.isEmpty;
    } catch (e) {
      log('SecureStorage: Error checking storage emptiness, Error: $e');
      return true;
    }
  }
}