import 'package:app/core/data/auth_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  Future<Resource<String>> authWithEmailAndPassword(String email, String password) =>
      _dataSource.authWithEmailAndPassword(email, password);

  Future<Resource<String>> authWithFacebook() => _dataSource.authWithFacebook();

  Future<Resource<String>> authWithGoogle() => _dataSource.authWithGoogle();

  Future<void> signOut() => _dataSource.signOut();

  Future<Resource<void>> signUp(User user) => _dataSource.signUp(user);

  Future<bool> sendEmailVerification(String email) => _dataSource.sendEmailVerification(email);

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(dynamic) onCompleted,
    Function(Exception) onFailed,
    Function(String, int) onCodeSent,
    Function(String) codeAutoRetrievalTimeout,
  ) {
    return _dataSource.verifyPhoneNumber(
      phoneNumber,
      onCompleted,
      onFailed,
      onCodeSent,
      codeAutoRetrievalTimeout,
    );
  }
}
