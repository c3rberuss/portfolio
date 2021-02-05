import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:bookshop/src/utils/validators.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ChangePasswordFormBloc extends FormBloc<String, String> {
  final UserRepository _repository;

  final currentPassword = TextFieldBloc(name: "password_actual", validators: [
    FieldsValidators.passwordLength,
    FieldsValidators.required,
  ]);

  final newPassword = TextFieldBloc(name: "password", validators: [
    FieldsValidators.passwordLength,
    FieldsValidators.required,
  ]);

  ChangePasswordFormBloc(this._repository) {
    addFieldBlocs(fieldBlocs: [
      currentPassword,
      newPassword,
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      final response = await _repository.setPassword(currentPassword.value, newPassword.value);

      if (response.code == 200) {
        emitSuccess(
          successResponse: "Su contraseña se actualizó exitosamente, "
              "requiere que se inicie sesión nuevamente.",
        );
      } else {
        emitFailure(
          failureResponse: "No se pudo actualizar su contraseña, intente nuevamente más tarde.",
        );
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT) {
        emitFailure(failureResponse: "Sin conexión a internet.");
      } else {
        emitFailure(failureResponse: "Oops! Algo salió mal, intente más tarde.");
      }
    }
  }

  @override
  Future<void> close() {
    currentPassword.close();
    newPassword.close();
    return super.close();
  }
}
