import 'package:app/core/data/shared_preferences_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:string_validator/string_validator.dart';

class SharedPreferencesSourceImpl extends SharedPreferencesSource {
  final _storage = FlutterSecureStorage();

  @override
  Future<void> remove(String key) async {
    _storage.delete(key: key);
  }

  @override
  Future<void> save<Type>(String key, Type value) async {
    if (value is String) {
      _storage.write(key: key, value: value);
    } else {
      _storage.write(key: key, value: toString(value));
    }
  }

  @override
  Future<String> getToken(String key) async {
    return Future.value(await _storage.read(key: key));
  }

  @override
  Future<double> getDouble(String key) async {
    final value = await _storage.read(key: key);
    return Future.value(double.parse(value));
  }

  @override
  Future<bool> getBool(String key) async {
    final value = await _storage.read(key: key);

    if (value != null) {
      return Future.value(toBoolean(value, true));
    }

    return Future.value(false);
  }

  @override
  Future<String> getString(String key) async {
    return Future.value(await _storage.read(key: key));
  }
}
