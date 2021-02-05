import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class DataChangeEvent extends RegisterEvent {
  final String name;
  final String email;
  final String phone;
  final String password;

  DataChangeEvent({this.name, this.email, this.phone, this.password});

  @override
  List<Object> get props => [name, email, phone, password];
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
  final String phone;
  final String password;

  SendDataEvent({this.name, this.email, this.phone, this.password});

  @override
  List<Object> get props => [name, email, phone, password];
}
