import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:megalibreria/src/models/orders/card_model.dart';

class CreditCardState extends Equatable {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool isCvvFocused;
  final bool isValidCard;
  final bool saveCard;
  final bool isValidCardNumber;
  final bool isValidExpiryDate;
  final bool isValidCardHolder;
  final bool isValidCvv;
  final CardModel card;
  final bool change;

  CreditCardState({
    @required this.cardNumber,
    @required this.expiryDate,
    @required this.cardHolderName,
    @required this.cvvCode,
    @required this.isCvvFocused,
    @required this.isValidCard,
    @required this.saveCard,
    @required this.card,
    @required this.isValidCardNumber,
    @required this.isValidCardHolder,
    @required this.isValidCvv,
    @required this.isValidExpiryDate,
    @required this.change,
  });

  factory CreditCardState.initial() {
    final card = CardModel((c) => c
      ..number = ""
      ..name = ""
      ..cvc = ""
      ..expMonth = 0
      ..expYear = 0);

    return CreditCardState(
      cardNumber: "",
      expiryDate: "",
      cardHolderName: "",
      cvvCode: "",
      isCvvFocused: false,
      isValidCard: false,
      saveCard: false,
      card: card,
      isValidCardNumber: false,
      isValidCardHolder: false,
      isValidCvv: false,
      isValidExpiryDate: false,
      change: false,
    );
  }

  CreditCardState copyWith({
    String cardNumber,
    String expiryDate,
    String cardHolderName,
    String cvvCode,
    bool isCvvFocused,
    bool isValid,
    bool saveCard,
    CardModel card,
    bool validCardNumber,
    bool validCvv,
    bool validExpiryDate,
    bool validHolder,
    bool change,
  }) {
    return CreditCardState(
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cvvCode: cvvCode ?? this.cvvCode,
      isCvvFocused: isCvvFocused ?? this.isCvvFocused,
      isValidCard: isValid ?? this.isValidCard,
      saveCard: saveCard ?? this.saveCard,
      card: card ?? this.card,
      isValidExpiryDate: validExpiryDate ?? this.isValidExpiryDate,
      isValidCvv: validCvv ?? this.isValidCvv,
      isValidCardHolder: validHolder ?? this.isValidCardHolder,
      isValidCardNumber: validCardNumber ?? this.isValidCardNumber,
      change: change ?? this.change,
    );
  }

  @override
  List<Object> get props => [
        cardNumber,
        expiryDate,
        cardHolderName,
        cvvCode,
        isCvvFocused,
        isValidCard,
        saveCard,
        card,
        isValidCardHolder,
        isValidCardNumber,
        isValidCvv,
        isValidExpiryDate,
        change,
      ];
}
