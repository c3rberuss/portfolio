import 'package:app/core/domain/user.dart';

abstract class LocalUserDataSource {
  Future<String> getIdToken();
  Future<User> getUserInfo();
}
