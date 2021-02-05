import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:services/src/blocs/credit_card/credit_card_state.dart';
import 'package:services/src/models/card_model.dart';

import './bloc.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final date = DateTime.now();

  @override
  CreditCardState get initialState => CreditCardState.initial();

  @override
  Stream<CreditCardState> mapEventToState(
    CreditCardEvent event,
  ) async* {
    if (event is ChangeCardNumberEvent) {
      yield state.copyWith(change: true);
      yield state.copyWith(
        cardNumber: event.cardNumber,
        validCardNumber: event.cardNumber.isNotEmpty && event.cardNumber.length >= 19,
        change: false,
      );
    } else if (event is ChangeExpiryEvent) {
      yield state.copyWith(change: true);

      bool validDate = false;
      final cardDate = event.expiryDate.split("/");
      if (cardDate.length == 2 && event.expiryDate.isNotEmpty) {
        validDate = int.parse(cardDate[0]) <= 12 && int.parse(cardDate[1]) >= (date.year - 2000);

        if (int.parse(cardDate[1]) == (date.year - 2000)) {
          validDate = int.parse(cardDate[0]) >= date.month;
        }
      }

      yield state.copyWith(
        expiryDate: event.expiryDate,
        validExpiryDate: validDate,
        change: false,
      );
    } else if (event is ChangeCvvEvent) {
      yield state.copyWith(change: true);

      yield state.copyWith(
        cvvCode: event.cvvCode,
        validCvv: event.cvvCode.isNotEmpty && event.cvvCode.length >= 3,
        change: false,
      );
    } else if (event is ChangeCardHolderEvent) {
      yield state.copyWith(change: true);
      yield state.copyWith(
        cardHolderName: event.cardHolderName.toUpperCase(),
        validHolder: event.cardHolderName.isNotEmpty,
        change: false,
      );
    } else if (event is CvvFocusedEvent) {
      yield state.copyWith(isCvvFocused: event.isCvvFocused);
    } else if (event is SaveCreditCardEvent) {
      final date = state.expiryDate.split("/");

      final card = CardModel((c) => c
        ..number = state.cardNumber
        ..name = state.cardHolderName
        ..cvc = state.cvvCode
        ..expMonth = int.parse(date[0])
        ..expYear = int.parse(date[1]));

      yield state.copyWith(saveCard: true, card: card);
    }

    yield state.copyWith(isValid: validCard());
  }

  bool validCard() {
    return state.isValidCardHolder &&
        state.isValidCardNumber &&
        state.isValidCvv &&
        state.isValidExpiryDate;
  }
}
