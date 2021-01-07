abstract class PreferencesRepository {
  void save<Type>(String key, Type value);

  void remove(String key);

  Future<String> getToken();

  Future<double> getDouble(String key);

  Future<bool> getBool(String key);
}
