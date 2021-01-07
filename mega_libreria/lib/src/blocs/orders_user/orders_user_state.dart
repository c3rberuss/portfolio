import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:megalibreria/src/models/orders/order_model.dart';

class OrdersUserState extends Equatable {
  final bool fetching;
  final bool fetchingFinalized;
  final bool refreshingFinalized;
  final BuiltList<OrderModel> orders;
  final bool noInternet;

  OrdersUserState({
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.refreshingFinalized,
    @required this.orders,
    @required this.noInternet,
  });

  factory OrdersUserState.initial() {
    return OrdersUserState(
      fetching: true,
      fetchingFinalized: false,
      refreshingFinalized: false,
      orders: BuiltList<OrderModel>(),
      noInternet: false,
    );
  }

  OrdersUserState copyWith({
    bool fetching,
    bool fetchingFinalized,
    bool refreshingFinalized,
    BuiltList<OrderModel> orders,
    bool noInternet,
  }) {
    return OrdersUserState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      refreshingFinalized: refreshingFinalized ?? this.refreshingFinalized,
      orders: orders ?? this.orders,
      noInternet: noInternet ?? this.noInternet,
    );
  }

  @override
  List<Object> get props => [
        fetching,
        orders,
        refreshingFinalized,
        fetchingFinalized,
        noInternet,
      ];
}
