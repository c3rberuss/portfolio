import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:services/src/models/user_model.dart';
import 'package:services/src/repositories/user_repository_impl.dart';

import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepositoryImpl repository;

  RegisterBloc(this.repository);

  @override
  RegisterState get initialState => RegisterState.initial();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SendDataEvent) {
      yield state.copyWith(sending: true);

      final user = UserModel((u) => u
        ..name = event.name
        ..email = event.email.trim()
        ..phone = event.phone
        ..password = event.password);

      try {
        final response = await repository.register(user);

        print(response);

        if (response.code == 201) {
          yield state.copyWith(
            sending: false,
            success: true,
            message: "Wellcome! your register is successfully. Please login.",
          );
        } else {
          yield state.copyWith(sending: false, error: true, message: "Already exists an account.");
        }

        yield state.copyWith(sending: false, error: false, success: false);
      } on DioError catch (error) {
        yield state.copyWith(sending: false, error: true, message: "Try again later!");

        yield state.copyWith(sending: false, error: false, success: false);
        if (error.response != null) {
          print(error.response.data);
        }
      }
    } else if (event is DataChangeEvent) {
      final bool passwordValid = event.password.isNotEmpty && event.password.length >= 8;
      final bool nameValid = event.name.isNotEmpty;
      final bool phoneValid = event.phone.isNotEmpty;

      yield state.copyWith(change: true);

      yield state.copyWith(
        validPhone: phoneValid,
        validPassword: passwordValid,
        validName: nameValid,
      );

      yield* _mapValidForm();
    } else if (event is EmailChangeEvent) {
      final bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email.trim());

      print("VALID EMAIL: $emailValid");

      yield state.copyWith(change: true);
      yield state.copyWith(validEmail: emailValid);
      yield* _mapValidForm();
    }
  }

  Stream<RegisterState> _mapValidForm() async* {
    if (state.isValidPhone && state.isValidName && state.isValidPassword && state.isValidEmail) {
      yield state.copyWith(validForm: true, change: false);
    } else {
      yield state.copyWith(validForm: false, change: false);
    }
  }
}
