import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/models/users/user_model.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository repository;

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
        ..lastName = event.lastName
        ..password = event.password);

      try {
        final response = await repository.register(user.toJson());

        print(response);

        if (response.code == 200) {
          yield state.copyWith(
            sending: false,
            success: true,
            message: "Bienvenido! Su registro fue exitoso. Por favor inicie sesión.",
          );
        } else {
          yield state.copyWith(
              sending: false,
              error: true,
              message: "Ya existe otra cuenta registrada con ese correo.");
        }

        yield state.copyWith(sending: false, error: false, success: false);
      } on DioError catch (error) {
        if (error.type == DioErrorType.DEFAULT) {
          yield state.copyWith(noInternet: true, sending: false);
        } else {
          yield state.copyWith(
              sending: false, error: true, message: "Algo salió mal, intente más tarde");
        }

        yield state.copyWith(sending: false, error: false, success: false, noInternet: false);
        if (error.response != null) {
          print(error.response.data);
        }
      }
    } else if (event is DataChangeEvent) {
      final bool passwordValid = event.password.isNotEmpty && event.password.length >= 8;
      final bool nameValid = event.name.trim().isNotEmpty;
      final bool lastNameValid = event.lastName.trim().isNotEmpty;
      final bool confirmPasswordValid =
          event.confirmPassword.isNotEmpty && event.confirmPassword == event.password;
      final bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email.trim());

      yield state.copyWith(change: !state.change);

      yield state.copyWith(
        validConfirmPassword: confirmPasswordValid,
        validEmail: emailValid,
        validLastName: lastNameValid,
        validPassword: passwordValid,
        validName: nameValid,
      );

      yield* _mapValidForm();
    } else if (event is EmailChangeEvent) {
      final bool emailValid =
          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(event.email.trim());

      yield state.copyWith(change: true);
      yield state.copyWith(validEmail: emailValid);
      yield* _mapValidForm();
    }
  }

  Stream<RegisterState> _mapValidForm() async* {
    yield state.copyWith(
      validForm: (state.isValidLastName &&
          state.isValidName &&
          state.isValidPassword &&
          state.isValidEmail &&
          state.isValidConfirmPassword),
    );
  }
}
