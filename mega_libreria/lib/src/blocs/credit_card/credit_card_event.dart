import 'package:equatable/equatable.dart';

abstract class CreditCardEvent extends Equatable {
  const CreditCardEvent();
}

class ChangeCardNumberEvent extends CreditCardEvent {
  final String cardNumber;

  ChangeCardNumberEvent(this.cardNumber);

  @override
  List<Object> get props => [cardNumber];
}

class ChangeExpiryEvent extends CreditCardEvent {
  final String expiryDate;

  ChangeExpiryEvent(this.expiryDate);

  @override
  List<Object> get props => [expiryDate];
}

class ChangeCardHolderEvent extends CreditCardEvent {
  final String cardHolderName;

  ChangeCardHolderEvent(this.cardHolderName);

  @override
  List<Object> get props => [cardHolderName];
}

class ChangeCvvEvent extends CreditCardEvent {
  final String cvvCode;

  ChangeCvvEvent(this.cvvCode);

  @override
  List<Object> get props => [cvvCode];
}

class CvvFocusedEvent extends CreditCardEvent {
  final bool isCvvFocused;

  CvvFocusedEvent(this.isCvvFocused);

  @override
  List<Object> get props => [isCvvFocused];
}

class SaveCreditCardEvent extends CreditCardEvent {
  @override
  List<Object> get props => [];
}
