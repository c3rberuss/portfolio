import 'package:bookshop/src/models/addresses/address_model.dart';
import 'package:bookshop/src/models/orders/card_model.dart';
import 'package:bookshop/src/models/orders/payment_type.dart';
import 'package:bookshop/src/models/products/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class AddOrderItemEvent extends OrderEvent {
  final ProductModel item;
  final int qty;

  AddOrderItemEvent(this.item, this.qty);

  @override
  List<Object> get props => [item, this.qty];
}

class RemoveItemEvent extends OrderEvent {
  final int pos;

  RemoveItemEvent(this.pos);

  @override
  List<Object> get props => [pos];
}

class ClearOrderEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class SendOrderEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class ChangeAddressEvent extends OrderEvent {
  final AddressModel address;

  ChangeAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

class ChangePaymentTypeEvent extends OrderEvent {
  final PaymentType type;

  ChangePaymentTypeEvent(this.type);

  @override
  List<Object> get props => [type];
}

class ChangeCreditCardEvent extends OrderEvent {
  final CardModel card;

  ChangeCreditCardEvent(this.card);

  @override
  List<Object> get props => [card];
}

class ChangeNeedChangeEvent extends OrderEvent {
  final bool value;

  ChangeNeedChangeEvent(this.value);

  @override
  List<Object> get props => [value];
}

class GetFaresEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}
