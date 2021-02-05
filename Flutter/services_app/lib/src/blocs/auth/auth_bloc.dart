import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/repositories/auth_repository_impl.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';

import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthState.initial();
  SPreferencesRepositoryImpl preferences;
  AuthRepositoryImpl authRepository;

  AuthBloc({@required this.preferences, @required this.authRepository});

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SignInEvent) {
      yield state.copyWith(authenticating: true);
      final response = await authRepository.auth(event.email.trim(), event.password);

      print(response);

      if (response.code == 200) {
        //Save user data
        preferences.save<String>("token", response.data.token);
        preferences.save<bool>("logged", true);
        yield state.copyWith(user: response.data, authSuccess: true, authenticating: false);
      } else {
        yield state.copyWith(authError: true, authenticating: false);
      }

      yield state.copyWith(authError: false, authSuccess: false);
    } else if (event is EmailChangedEvent) {
      final bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email.trim());

      yield state.copyWith(email: event.email, validEmail: emailValid, authenticating: false);
    } else if (event is PasswordChangedEvent) {
      final bool passwordValid = event.password.length >= 8;

      yield state.copyWith(
          password: event.password, validPassword: passwordValid, authenticating: false);
    }
  }
}
