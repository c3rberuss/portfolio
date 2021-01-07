import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';
import 'package:megalibreria/src/models/locations/city_model.dart';
import 'package:megalibreria/src/models/locations/department_model.dart';
import 'package:megalibreria/src/models/response/response_form_clasess.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import 'package:megalibreria/src/utils/validators.dart';

class ProfileFormBloc extends FormBloc<SuccessResponse<UserModel>, FailResponse<ErrorType>> {
  final UserModel user;
  final UserRepository userRepository;
  final bool isEditing;

  final editProfile = BooleanFieldBloc(initialValue: false);

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

  final department = SelectFieldBloc<DepartmentModel, String>(
      name: "departamento", validators: [FieldsValidators.required]);

  final city = SelectFieldBloc<CityModel, String>(
      name: "municipio", validators: [FieldsValidators.required]);

  final address = InputFieldBloc<AddressModel, String>(
    name: "direccion",
    validators: [
      FieldsValidators.required,
    ],
  );

  ProfileFormBloc({@required this.user, @required this.userRepository, this.isEditing = false}) {
    editProfile.updateInitialValue(this.isEditing);
    name.updateInitialValue(this.user.name);
    lastName.updateInitialValue(this.user.lastName);
    phone.updateInitialValue(this.user.phone);
    email.updateInitialValue(this.user.email);

    if (this.user.address.isNotEmpty) {
      address.updateInitialValue(AddressModel(
        (a) => a
          ..address = this.user.address
          ..latitude = this.user.latitude
          ..longitude = this.user.longitude,
      ));
    }

    department.updateInitialValue(this.user.department);
    city.updateInitialValue(this.user.city);

    addFieldBlocs(fieldBlocs: [
      editProfile,
      name,
      lastName,
      phone,
      email,
      department,
      city,
      address,
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    if (editProfile.value) {
      try {
        final newData = UserModel(
          (u) => u
            ..name = name.value
            ..lastName = lastName.value
            ..phone = phone.value
            ..email = email.value
            ..address = address.value.address
            ..latitude = address.value.latitude
            ..longitude = address.value.longitude
            ..department = user.department.toBuilder()
            ..city = user.city.toBuilder(),
        );

        final response = await userRepository.update(newData);

        print(response);

        if (response.code == 200) {
          emitSuccess(
            successResponse: SuccessResponse<UserModel>(
                data: newData, message: "Su perfil se actualizó correctamente!"),
            canSubmitAgain: true,
          );
        } else {
          emitFailure(
            failureResponse: FailResponse<ErrorType>(
              data: ErrorType.unknown,
              message: response.message,
            ),
          );
        }
      } on DioError catch (error) {
        if (error.type == DioErrorType.DEFAULT) {
          emitFailure(
            failureResponse: FailResponse<ErrorType>(
              data: ErrorType.noInternet,
              message: "No tiene acceso a internet!",
            ),
          );
        }
      }
    }
  }

  @override
  Future<void> close() {
    editProfile.close();
    name.close();
    lastName.close();
    phone.close();
    email.close();
    department.close();
    city.close();
    address.close();
    return super.close();
  }
}
