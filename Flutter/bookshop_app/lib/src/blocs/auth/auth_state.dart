import 'package:bookshop/src/models/users/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool validEmail;
  final bool validPassword;
  final bool authError;
  final bool authSuccess;
  final bool authenticating;
  final UserModel user;
  final bool validData;
  final bool noInternet;

  AuthState({
    @required this.email,
    @required this.password,
    @required this.validEmail,
    @required this.validPassword,
    @required this.authError,
    @required this.authSuccess,
    @required this.authenticating,
    @required this.user,
    @required this.validData,
    @required this.noInternet,
  });

  factory AuthState.initial() {
    return AuthState(
      email: "",
      password: "",
      validEmail: false,
      validPassword: false,
      authError: false,
      authSuccess: false,
      authenticating: false,
      user: null,
      validData: false,
      noInternet: false,
    );
  }

  AuthState copyWith({
    String email,
    String password,
    bool validEmail,
    bool validPassword,
    bool authError,
    bool authSuccess,
    bool authenticating,
    UserModel user,
    bool valid,
    bool noInternet,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      validEmail: validEmail ?? this.validEmail,
      validPassword: validPassword ?? this.validPassword,
      authError: authError ?? this.authError,
      authSuccess: authSuccess ?? this.authSuccess,
      authenticating: authenticating ?? this.authenticating,
      user: user ?? this.user,
      validData: valid ?? this.validData,
      noInternet: noInternet ?? this.noInternet,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        validEmail,
        validPassword,
        authError,
        authSuccess,
        authenticating,
        user,
        validData,
        noInternet,
      ];
}
