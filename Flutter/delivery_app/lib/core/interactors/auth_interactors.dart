import 'package:app/core/data/auth_repository.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/user.dart';

class SignInWithEmailInt {
  final AuthRepository _repository;

  SignInWithEmailInt(this._repository);

  Future<Resource<String>> call(String email, String password) =>
      _repository.authWithEmailAndPassword(email, password);
}

class SignInWithFacebookInt {
  final AuthRepository _repository;

  SignInWithFacebookInt(this._repository);

  Future<Resource<String>> call() => _repository.authWithFacebook();
}

class SignInWithGoogleInt {
  final AuthRepository _repository;

  SignInWithGoogleInt(this._repository);

  Future<Resource<String>> call() => _repository.authWithGoogle();
}

class SignOutInt {
  final AuthRepository _repository;

  SignOutInt(this._repository);

  Future<void> call() => _repository.signOut();
}

class SignUpInt {
  final AuthRepository _repository;

  SignUpInt(this._repository);

  Future<Resource> call(User user) => _repository.signUp(user);
}

class VerifyPhoneNumberInt {
  final AuthRepository _repository;

  VerifyPhoneNumberInt(this._repository);

  Future<void> call(
    String phoneNumber,
    Function(dynamic) onCompleted,
    Function(Exception) onFailed,
    Function(String, int) onCodeSent,
    Function(String) codeAutoRetrievalTimeout,
  ) {
    return _repository.verifyPhoneNumber(
      phoneNumber,
      onCompleted,
      onFailed,
      onCodeSent,
      codeAutoRetrievalTimeout,
    );
  }
}

class VerifyEmailInt {
  final AuthRepository _repository;

  VerifyEmailInt(this._repository);

  Future<bool> call(String email) => _repository.sendEmailVerification(email);
}
