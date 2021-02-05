import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RegisterState extends Equatable {
  final bool sendingData;
  final bool registerSuccessfully;
  final bool registerFailed;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidName;
  final bool isValidPhone;
  final bool isValidData;
  final String message;
  final bool change;

  RegisterState({
    @required this.sendingData,
    @required this.registerSuccessfully,
    @required this.registerFailed,
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isValidName,
    @required this.isValidPhone,
    @required this.isValidData,
    @required this.message,
    @required this.change,
  });

  factory RegisterState.initial() {
    return RegisterState(
      sendingData: false,
      registerSuccessfully: false,
      registerFailed: false,
      isValidEmail: false,
      isValidPassword: false,
      isValidName: false,
      isValidPhone: false,
      isValidData: false,
      message: "",
      change: false,
    );
  }

  RegisterState copyWith({
    bool sending,
    bool success,
    bool error,
    bool validEmail,
    bool validPassword,
    bool validName,
    bool validPhone,
    bool validForm,
    String message,
    bool change,
  }) {
    return RegisterState(
      sendingData: sending ?? this.sendingData,
      registerSuccessfully: success ?? this.registerSuccessfully,
      registerFailed: error ?? this.registerFailed,
      isValidEmail: validEmail ?? this.isValidEmail,
      isValidPassword: validPassword ?? this.isValidPassword,
      isValidName: validName ?? this.isValidName,
      isValidPhone: validPhone ?? this.isValidPhone,
      isValidData: validForm ?? this.isValidData,
      message: message ?? this.message,
      change: change ?? this.change,
    );
  }

  @override
  List<Object> get props => [
        isValidData,
        isValidEmail,
        isValidPassword,
        isValidName,
        isValidPhone,
        sendingData,
        registerFailed,
        registerSuccessfully,
        message,
        change,
      ];
}
