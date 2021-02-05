import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class EmailOrPasswordChangedEvent extends AuthEvent {
  final String email;
  final String password;

  EmailOrPasswordChangedEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}

class EmailChangedEvent extends AuthEvent {
  final String email;

  EmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends AuthEvent {
  final String password;

  PasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}
