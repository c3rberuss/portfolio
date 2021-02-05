import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:services/src/models/user_model.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final bool validEmail;
  final bool validPassword;
  final bool authError;
  final bool authSuccess;
  final bool authenticating;
  final UserModel user;

  AuthState({
    @required this.email,
    @required this.password,
    @required this.validEmail,
    @required this.validPassword,
    @required this.authError,
    @required this.authSuccess,
    @required this.authenticating,
    @required this.user,
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
        user: null);
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
      ];
}
