import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RegisterState extends Equatable {
  final bool sendingData;
  final bool registerSuccessfully;
  final bool registerFailed;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidName;
  final bool isValidLastName;
  final bool isValidConfirmPassword;
  final bool isValidData;
  final String message;
  final bool change;
  final bool noInternet;

  RegisterState({
    @required this.sendingData,
    @required this.registerSuccessfully,
    @required this.registerFailed,
    @required this.isValidEmail,
    @required this.isValidPassword,
    @required this.isValidName,
    @required this.isValidData,
    @required this.message,
    @required this.change,
    @required this.noInternet,
    @required this.isValidConfirmPassword,
    @required this.isValidLastName,
  });

  factory RegisterState.initial() {
    return RegisterState(
      sendingData: false,
      registerSuccessfully: false,
      registerFailed: false,
      isValidEmail: false,
      isValidPassword: false,
      isValidName: false,
      isValidData: false,
      message: "",
      change: false,
      noInternet: false,
      isValidConfirmPassword: false,
      isValidLastName: false,
    );
  }

  RegisterState copyWith({
    bool sending,
    bool success,
    bool error,
    bool validEmail,
    bool validPassword,
    bool validName,
    bool validLastName,
    bool validConfirmPassword,
    bool validForm,
    String message,
    bool change,
    bool noInternet,
  }) {
    return RegisterState(
      sendingData: sending ?? this.sendingData,
      registerSuccessfully: success ?? this.registerSuccessfully,
      registerFailed: error ?? this.registerFailed,
      isValidEmail: validEmail ?? this.isValidEmail,
      isValidPassword: validPassword ?? this.isValidPassword,
      isValidName: validName ?? this.isValidName,
      isValidData: validForm ?? this.isValidData,
      message: message ?? this.message,
      change: change ?? this.change,
      noInternet: noInternet ?? this.noInternet,
      isValidLastName: validLastName ?? this.isValidLastName,
      isValidConfirmPassword: validConfirmPassword ?? this.isValidConfirmPassword,
    );
  }

  @override
  List<Object> get props => [
        isValidData,
        isValidEmail,
        isValidPassword,
        isValidName,
        sendingData,
        registerFailed,
        registerSuccessfully,
        message,
        change,
        noInternet,
        isValidLastName,
        isValidConfirmPassword,
      ];
}
