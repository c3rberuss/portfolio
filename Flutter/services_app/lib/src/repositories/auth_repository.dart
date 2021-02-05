import 'package:services/src/models/user_response.dart';

abstract class AuthRepository {
  Future<UserResponse> auth(String email, String password);

  Future<UserResponse> verify();

  void logout();
}
