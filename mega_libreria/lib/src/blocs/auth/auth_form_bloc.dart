import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/repositories/auth_repository_impl.dart';
import 'package:megalibreria/src/repositories/preferences_repository.dart';
import 'package:megalibreria/src/utils/validators.dart';

class AuthFormBloc extends FormBloc<UserModel, String> {
  final AuthRepositoryImpl _repository;
  final PreferencesRepository _preferences;

  final email = TextFieldBloc(name: "email", validators: [
    FieldsValidators.email,
    FieldsValidators.required,
  ]);

  final password = TextFieldBloc(name: "password", validators: [
    FieldsValidators.passwordLength,
    FieldsValidators.required,
  ]);

  AuthFormBloc(this._repository, this._preferences) {
    addFieldBlocs(fieldBlocs: [email, password]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      final response = await _repository.auth(email.value, password.value);

      if (response.code == 200) {
        _preferences.save<String>("token", response.data.token);
        emitSuccess(successResponse: response.data);
      } else {
        emitFailure(failureResponse: "¡Credenciales incorrectas!");
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT) {
        emitFailure(failureResponse: "Sin conexión a internet");
      }
    }
  }

  @override
  Future<void> close() {
    email.close();
    password.close();
    return super.close();
  }
}
