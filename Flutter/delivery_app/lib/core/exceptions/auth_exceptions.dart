class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class AccountExistsWithDifferentCredentialException extends AuthException {
  AccountExistsWithDifferentCredentialException([
    String message = "Account exists with different credentials.",
  ]) : super(message);
}

class EmailAlreadyExistException extends AuthException {
  EmailAlreadyExistException([
    String message = "Email already exist.",
  ]) : super(message);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException([
    String message = "User not found.",
  ]) : super(message);
}

class PhoneNumberAlreadyExistsException extends AuthException {
  PhoneNumberAlreadyExistsException([
    String message = "Phone number already exists.",
  ]) : super(message);
}

class WrongPasswordException extends AuthException {
  WrongPasswordException([
    String message = "Wrong password.",
  ]) : super(message);
}

class UnknownAuthException extends AuthException {
  UnknownAuthException([
    String message = "Unknown error.",
  ]) : super(message);
}

class WeakPasswordException extends AuthException {
  WeakPasswordException([
    String message = "Weak password.",
  ]) : super(message);
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException([
    String message = "Email already in use.",
  ]) : super(message);
}

class AuthCancelledException extends AuthException {
  AuthCancelledException([
    String message = "Auth was cancelled by the user.",
  ]) : super(message);
}

class AuthFailedException extends AuthException {
  AuthFailedException([
    String message = "Auth failed.",
  ]) : super(message);
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException([
    String message = "Too many requests",
  ]) : super(message);
}
