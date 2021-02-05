import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterFormBloc extends FormBloc<String, String> {
  final UserRepository _repository;

  final name = TextFieldBloc(
    name: "nombre",
    validators: [
      FieldsValidators.required,
    ],
  );

  final lastName = TextFieldBloc(
    name: "apellido",
    validators: [
      FieldsValidators.required,
    ],
  );

  final phone = TextFieldBloc(
    name: "telefono",
    validators: [
      FieldsValidators.required,
      FieldsValidators.phoneNumber,
    ],
  );

  final email = TextFieldBloc(name: "email", validators: [
    FieldsValidators.email,
    FieldsValidators.required,
  ]);

  final password = TextFieldBloc(name: "password", validators: [
    FieldsValidators.passwordLength,
    FieldsValidators.required,
  ]);

  final confirmPassword = TextFieldBloc(name: "confirm_password", validators: [
    FieldsValidators.required,
  ]);

  RegisterFormBloc(this._repository) {
    addFieldBlocs(step: 0, fieldBlocs: [
      name,
      lastName,
      phone,
    ]);

    addFieldBlocs(step: 1, fieldBlocs: [
      email,
      password,
      confirmPassword,
    ]);

    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);
  }

  @override
  Future<void> onSubmitting() async {
    if (state.isLastStep) {
      try {
        final response = await _repository.register(state.toJson());

        if (response.code == 200) {
          emitSuccess(
              successResponse: "Su cuenta fue creada exitosamente. Puede iniciar sesión ahora.");
        } else if (response.code == 303) {
          emitFailure(failureResponse: "Ya existe una cuenta con ese correo.");
        } else {
          emitFailure(failureResponse: "Oops! Ha ocurrido un error!");
        }
      } on DioError catch (error) {
        if (error.type == DioErrorType.DEFAULT) {
          emitFailure(failureResponse: "No posee conexión a internet!");
        }
      }
    } else {
      emitSuccess();
    }
  }

  Validator<String> _confirmPassword(TextFieldBloc password) {
    return (String value) {
      if (value == password.value) {
        return null;
      }
      return "Las contraseñas deben coincidir.";
    };
  }

  @override
  Future<void> close() {
    name.close();
    lastName.close();
    phone.close();
    email.close();
    password.close();
    confirmPassword.close();
    return super.close();
  }
}
