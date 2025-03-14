// ignore_for_file: public_member_api_docs, sort_constructors_first, type_literal_in_constant_pattern
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

class SharedPreferencesLocalStorageImp implements LocalStorage {
  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();
  @override
  Future<void> clear() async {
    final sharedPreferences = await _instance;
    sharedPreferences.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final sharedPreferences = await _instance;
    return sharedPreferences.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final sharedPreferences = await _instance;
    return sharedPreferences.get(key) == null ? null : sharedPreferences.get(key) as V;
  }

  @override
  Future<void> remove(String key) async {
    final sharedPreferences = await _instance;
    sharedPreferences.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final sharedPreferences = await _instance;
    switch (V) {
      case String:
        await sharedPreferences.setString(key, value as String);
        break;
      case int:
        await sharedPreferences.setInt(key, value as int);
        break;
      case bool:
        await sharedPreferences.setBool(key, value as bool);
        break;
      case double:
        await sharedPreferences.setDouble(key, value as double);
        break;
      case const (List<String>):
        await sharedPreferences.setStringList(key, value as List<String>);
        break;
      default:
        throw Exception('Tipo não suportado');
    }
  }
}
