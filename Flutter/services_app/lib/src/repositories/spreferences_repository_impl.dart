import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './spreferences_repository.dart';
import 'package:string_validator/string_validator.dart';

class SPreferencesRepositoryImpl extends SPreferencesRepository {
  final String _tokenKey = "token";
  final _storage = FlutterSecureStorage();

  @override
  Future<void> remove(String key) async {
    /*final _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.remove(key);*/
    _storage.delete(key: key);

  }

  @override
  Future<void> save<Type>(String key, Type value) async {

    //final _sharedPreferences = await SharedPreferences.getInstance();

    if (value is String) {
      _storage.write(key: key, value: value);
      //_sharedPreferences.setString(key, value);
    }else{
      _storage.write(key: key, value: toString(value));
    }/*else if (value is int) {
      _storage.write(key: key, value: toString(value));
      //_sharedPreferences.setInt(key, value);
    } else if (value is double) {
      _storage.write(key: key, value: (value).toString());
      //_sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      _storage.write(key: key, value: (value).toString());
      //_sharedPreferences.setBool(key, value);
    }*/
    //}
  }

  @override
  Future<String> getToken() async {
    /*final _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getString(_tokenKey));*/
    return Future.value(await _storage.read(key: _tokenKey));
  }

  @override
  Future<double> getDouble(String key) async {
  /*  final _sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(_sharedPreferences.getDouble(key));*/
    final value = await _storage.read(key: key);
    return Future.value(double.parse(value));

  }

  @override
  Future<bool> getBool(String key) async {
    final value = await _storage.read(key: key);

    if(value != null){
      return Future.value(toBoolean(value, true));
    }

    return Future.value(false);
  }
}
