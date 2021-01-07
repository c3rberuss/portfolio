import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:megalibreria/src/models/orders/card_model.dart';
import 'package:megalibreria/src/presentation/widgets/input.dart';

class CreditCardFormBloc extends FormBloc<CardModel, String> {
  final cardNumber = TextFieldBloc();
  final expDate = InputFieldBloc<DateTime, Object>();
  final cvv = TextFieldBloc();
  final holder = TextFieldBloc();

  CreditCardFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        cardNumber,
        expDate,
        cvv,
        holder,
      ],
    );
  }

  @override
  void onSubmitting() {
    final creditCard = CardModel(
      (card) => card
        ..number = cardNumber.value
        ..cvc = cvv.value
        ..expMonth = getValue("MM", expDate.value)
        ..expYear = getValue("yy", expDate.value)
        ..name = holder.value,
    );

    emitSuccess(successResponse: creditCard);
  }

  @override
  Future<void> close() {
    cardNumber.close();
    expDate.close();
    cvv.close();
    holder.close();
    return super.close();
  }

  int getValue(String formatter, DateTime value) {
    final f = DateFormat(formatter);
    return int.parse(f.format(value));
  }
}
