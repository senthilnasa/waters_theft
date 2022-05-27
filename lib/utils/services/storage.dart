import 'package:get_storage/get_storage.dart';

class Prefs {
  static final _prefs = GetStorage();

  ///setters
  static Future<void> write(String key, dynamic value) async =>
      await _prefs.write(key, value);

  ///getters
  static T? read<T>(String key) => _prefs.read<T>(key);

  /// check key
  static bool hasData(String key) => _prefs.hasData(key);

  /// Delete single key and its value from SharedPreferences.
  static Future<void> remove(String key) async => await _prefs.remove(key);

  /// Clears all the preferences stored in the device.
  static Future<void> clear() async => await _prefs.erase();
}
