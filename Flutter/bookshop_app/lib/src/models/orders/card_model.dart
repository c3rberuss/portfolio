import 'package:built_value/built_value.dart';

part 'card_model.g.dart';

abstract class CardModel implements Built<CardModel, CardModelBuilder> {

  String get number;
  String get cvc;
  String get name;
  int get expMonth;
  int get expYear;

  CardModel._();
  factory CardModel([void Function(CardModelBuilder) updates]) = _$CardModel;
}