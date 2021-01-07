import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';
import 'package:megalibreria/src/models/orders/card_model.dart';
import 'package:megalibreria/src/models/response/response_form_clasess.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import 'package:megalibreria/src/utils/validators.dart';

class FinishOrderBlocForm extends FormBloc<String, FailResponse<ErrorType>> {
  final UserRepository repository;
  final UserModel user;

  FinishOrderBlocForm(this.repository, this.user) {
    addFieldBlocs(
      fieldBlocs: <FieldBloc>[
        serviceType,
        address,
        paymentType,
        requireChange,
      ],
    );

    if (this.user.address.isNotEmpty) {
      address.updateInitialValue(this.user.address);
    }

    serviceType.onValueChanges(onData: (old, current) async* {
      if (current.value == "A domicilio") {
        addFieldBloc(fieldBloc: address);
        removeFieldBloc(fieldBloc: branch);

        if(paymentType.value == "Efectivo"){
          addFieldBloc(fieldBloc: requireChange);

          if(requireChange.value == "Si"){
            addFieldBloc(fieldBloc: changeOf);
          }
        }

      } else {
        addFieldBloc(fieldBloc: branch);
        removeFieldBlocs(
          fieldBlocs: [address, requireChange, changeOf],
        );
      }
    });

    paymentType.onValueChanges(onData: (old, current) async* {
      if (current.value == "Efectivo") {
        if(serviceType.value == "A domicilio"){
          addFieldBloc(fieldBloc: requireChange);
        }

        if(requireChange.value == "Si"){
          addFieldBloc(fieldBloc: changeOf);
        }

        removeFieldBloc(fieldBloc: creditCard);
      } else if (current.value == "Tarjeta de crédito/débito") {
        addFieldBloc(fieldBloc: creditCard);
        removeFieldBlocs(fieldBlocs:[requireChange, changeOf] );
      }
    });

    requireChange.onValueChanges(onData: (old, current) async* {
      if (current.value == "Si") {
        addFieldBloc(fieldBloc: changeOf);
      } else {
        removeFieldBloc(fieldBloc: changeOf);
      }
    });
  }

  final serviceType = SelectFieldBloc(
    items: ["A domicilio", "Recoger en sucursal"],
    initialValue: "A domicilio",
    validators: [
      FieldsValidators.required,
    ],
  );

  final address = InputFieldBloc<String, Object>(
    validators: [
      FieldsValidators.required,
    ],
  );

  final paymentType = SelectFieldBloc(
    items: ["Efectivo", "Tarjeta de crédito/débito"],
    initialValue: "Efectivo",
    validators: [
      FieldsValidators.required,
    ],
  );

  final creditCard = InputFieldBloc<CardModel, Object>(
    validators: [
      FieldsValidators.required,
    ],
  );

  final requireChange = SelectFieldBloc(
    initialValue: "No",
    items: ["Si", "No"],
    validators: [
      FieldsValidators.required,
    ],
  );

  final changeOf = SelectFieldBloc(
    items: ["\$5", "\$10", "\$20", "\$50",],
    initialValue: "\$5",
    validators: [
      FieldsValidators.required,
    ],
  );

  final branch = InputFieldBloc(
    validators: [
      FieldsValidators.required,
    ],
  );

  @override
  void onSubmitting() {}

  @override
  Future<void> close() {
    serviceType.close();
    paymentType.close();
    address.close();
    creditCard.close();
    requireChange.close();
    branch.close();
    changeOf.close();

    return super.close();
  }
}
