import 'package:bookshop/src/models/addresses/address_model.dart';
import 'package:bookshop/src/models/orders/card_model.dart';
import 'package:bookshop/src/models/orders/fare_model.dart';
import 'package:bookshop/src/models/orders/order_detail_model.dart';
import 'package:bookshop/src/models/orders/payment_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class OrderState extends Equatable {
  final bool success;
  final bool error;
  final bool sending;
  final bool deleted;
  final bool companyDistinct;
  final bool added;
  final double subtotal;
  final bool needChange;
  final int companyId;
  final AddressModel address;
  final PaymentType paymentType;
  final FareModel fare;
  final List<OrderDetailModel> detail;
  final FareModel card;
  final bool noInternet;
  final bool fetchingFares;

  OrderState({
    @required this.success,
    @required this.error,
    @required this.sending,
    @required this.deleted,
    @required this.added,
    @required this.subtotal,
    @required this.detail,
    @required this.companyId,
    @required this.companyDistinct,
    @required this.address,
    @required this.paymentType,
    @required this.fare,
    @required this.card,
    @required this.needChange,
    @required this.noInternet,
    @required this.fetchingFares,
  });

  factory OrderState.initial() {
    return OrderState(
      success: false,
      error: false,
      sending: false,
      deleted: false,
      added: false,
      subtotal: 0.0,
      detail: [],
      companyId: -1,
      companyDistinct: false,
      address: null,
      paymentType: PaymentType.cash,
      fare: FareModel(
        (f) => f
          ..fare = 0.0
          ..total = 0.0
          ..minimum = 0.0,
      ),
      card: null,
      needChange: false,
      noInternet: false,
      fetchingFares: false,
    );
  }

  OrderState copyWith({
    bool success,
    bool error,
    bool sending,
    bool deleted,
    bool added,
    double subtotal,
    List<OrderDetailModel> detail,
    int companyId,
    bool companyDistinct,
    AddressModel address,
    PaymentType paymentType,
    FareModel fare,
    CardModel card,
    bool needChange,
    bool noInternet,
    bool fetchingFares,
  }) {
    return OrderState(
      success: success ?? this.success,
      error: error ?? this.error,
      sending: sending ?? this.sending,
      deleted: deleted ?? this.deleted,
      added: added ?? this.deleted,
      subtotal: subtotal ?? this.subtotal,
      detail: detail ?? this.detail,
      companyId: companyId ?? this.companyId,
      companyDistinct: companyDistinct ?? this.companyDistinct,
      address: address ?? this.address,
      paymentType: paymentType ?? this.paymentType,
      fare: fare ?? this.fare,
      card: card ?? this.card,
      needChange: needChange ?? this.needChange,
      noInternet: noInternet ?? this.noInternet,
      fetchingFares: fetchingFares ?? this.fetchingFares,
    );
  }

  @override
  List<Object> get props => [
        success,
        error,
        sending,
        deleted,
        added,
        subtotal,
        detail,
        companyId,
        companyDistinct,
        address,
        paymentType,
        fare,
        card,
        needChange,
        noInternet,
        fetchingFares,
      ];
}
