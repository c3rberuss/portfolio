import 'package:equatable/equatable.dart';

abstract class OrdersUserEvent extends Equatable {
  const OrdersUserEvent();
}

class FetchOrdersUserEvent extends OrdersUserEvent {
  @override
  List<Object> get props => [];
}

class RefreshOrdersUserEvent extends OrdersUserEvent {
  @override
  List<Object> get props => [];
}

class ClearStateEvent extends OrdersUserEvent {
  @override
  List<Object> get props => [];
}

class RateOrderEvent extends OrdersUserEvent {
  final double rate;
  final int orderId;

  RateOrderEvent(this.orderId, this.rate);

  @override
  List<Object> get props => [rate, orderId];
}
