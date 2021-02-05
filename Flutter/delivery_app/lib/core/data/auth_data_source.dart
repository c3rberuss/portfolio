import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

abstract class AuthDataSource {
  Future<Resource<String>> authWithEmailAndPassword(String email, String password);
  Future<Resource<String>> authWithFacebook();
  Future<Resource<String>> authWithGoogle();
  Future<Resource<void>> signUp(User user);
  Future<bool> sendEmailVerification(String email);
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(dynamic) onCompleted,
    Function(Exception) onFailed,
    Function(String, int) onCodeSent,
    Function(String) codeAutoRetrievalTimeout,
  );
  Future<void> signOut();
}
