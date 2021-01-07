import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class DataChangeEvent extends RegisterEvent {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;

  DataChangeEvent({this.name, this.email, this.lastName, this.password, this.confirmPassword});

  @override
  List<Object> get props => [name, email, lastName, password, confirmPassword];
}

class EmailChangeEvent extends RegisterEvent {
  final String email;

  EmailChangeEvent(this.email);

  @override
  List<Object> get props => [email];
}

class SendDataEvent extends RegisterEvent {
  final String name;
  final String email;
  final String lastName;
  final String password;

  SendDataEvent({this.name, this.email, this.lastName, this.password});

  @override
  List<Object> get props => [name, email, lastName, password];
}
