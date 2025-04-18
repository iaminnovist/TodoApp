import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  late final SharedPreferences _prefs;
  bool _initialized = false;

  StorageService();

  Future<void> init() async {
    if (!_initialized) {
      _prefs = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  // Secure Storage Methods
  Future<void> setSecureString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureString(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecureString(String key) async {
    await _secureStorage.delete(key: key);
  }

  // SharedPreferences Methods
  Future<void> setBool(String key, bool value) async {
    await _ensureInitialized();
    await _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    await _ensureInitialized();
    return _prefs.getBool(key);
  }

  Future<void> setString(String key, String value) async {
    await _ensureInitialized();
    await _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    await _ensureInitialized();
    return _prefs.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _ensureInitialized();
    await _prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    await _ensureInitialized();
    return _prefs.getInt(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _ensureInitialized();
    await _prefs.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    await _ensureInitialized();
    return _prefs.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _ensureInitialized();
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _ensureInitialized();
    await _prefs.clear();
  }

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      await init();
    }
  }
} 