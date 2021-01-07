import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';
import 'package:megalibreria/src/utils/validators.dart';

class ChangeAddressFormBloc extends FormBloc<AddressModel, String> {
  final address = TextFieldBloc(
    name: "address",
    validators: [
      FieldsValidators.required,
    ],
  );

  final houseNumber = TextFieldBloc(
    name: "houseNumber",
    validators: [
      FieldsValidators.required,
    ],
  );

  ChangeAddressFormBloc() {
    addFieldBlocs(fieldBlocs: [
      address,
      houseNumber,
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    final data = AddressModel(
      (a) => a..address = address.value + ", " + houseNumber.value
    );

    emitSuccess(successResponse: data);
  }

  @override
  Future<void> close() {
    houseNumber.close();
    address.close();
    return super.close();
  }
}
