import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

abstract class RemoteUserDataSource {
  Future<Resource<User>> getUserInfo();
  Future<Resource<String>> linkWithFacebook();
  Future<Resource<String>> linkWithGoogle();
  Future<Resource<String>> linkWithEmail(String email, String password);
}
