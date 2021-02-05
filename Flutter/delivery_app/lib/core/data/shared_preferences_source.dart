abstract class SharedPreferencesSource {
  void save<Type>(String key, Type value);

  void remove(String key);

  Future<String> getToken(String tokenKey);

  Future<double> getDouble(String key);

  Future<bool> getBool(String key);

  Future<String> getString(String key);
}
