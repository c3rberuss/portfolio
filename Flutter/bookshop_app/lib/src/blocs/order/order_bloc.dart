import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/models/orders/order_detail_model.dart';
import 'package:bookshop/src/models/orders/order_model.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';

import './bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final UserRepository _repository;

  OrderBloc(this._repository);

  @override
  OrderState get initialState => OrderState.initial();

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    if (event is AddOrderItemEvent) {
      final index = this.state.detail.indexWhere((item) => item.productId == event.item.id);

      if (index > -1) {
        yield state.copyWith(
          subtotal: (state.subtotal + (event.item.price * event.qty)),
          detail: state.detail
            ..[index] = state.detail[index].rebuild(
              (detail) => detail
                ..quantity += event.qty
                ..subtotal += (event.qty * event.item.price),
            ),
        );
      } else {
        yield state.copyWith(
          detail: state.detail..add(_mapItem(event)),
          subtotal: (state.subtotal + (event.item.price * event.qty)),
        );
      }
    } else if (event is RemoveItemEvent) {
      final item = state.detail[event.pos];

      yield state.copyWith(
        subtotal: state.subtotal > 0 ? state.subtotal - item.subtotal : 0,
        detail: state.detail..removeAt(event.pos),
        deleted: !state.deleted,
      );

      yield* _mapFares();
    } else if (event is ClearOrderEvent) {
      yield OrderState.initial();
    } else if (event is SendOrderEvent) {
      yield state.copyWith(sending: true);

      final order = OrderModel((order) => order
        ..total = state.subtotal
        ..detail = ListBuilder(state.detail));

      print(order);

      try {
        final response = await _repository.createOrder(order);
        yield state.copyWith(sending: false);

        if (response.code == 201) {
          yield state.copyWith(success: true);
        } else {
          yield state.copyWith(error: true);
        }

        yield OrderState.initial();
      } on DioError catch (error) {
        if (error.type == DioErrorType.DEFAULT) {
          yield state.copyWith(noInternet: true, sending: false);
        } else {
          yield state.copyWith(error: true, sending: false);
        }

        yield state.copyWith(error: false, success: false, noInternet: false);
      }

      //print(response);
    } else if (event is ChangeAddressEvent) {
      yield state.copyWith(address: event.address);
    } else if (event is ChangePaymentTypeEvent) {
      yield state.copyWith(paymentType: event.type);
    } else if (event is ChangeCreditCardEvent) {
      yield state.copyWith(card: event.card);
    } else if (event is ChangeNeedChangeEvent) {
      yield state.copyWith(needChange: event.value);
    } else if (event is GetFaresEvent) {
      yield* _mapFares();
    }
  }

  OrderDetailModel _mapItem(AddOrderItemEvent event) {
    return OrderDetailModel(
      (item) => item
        ..name = event.item.name
        ..price = event.item.price
        ..productId = event.item.id
        ..image = event.item.image
        ..subtotal = (event.qty * event.item.price)
        ..quantity = event.qty,
    );
  }

  Stream<OrderState> _mapFares() async* {
    yield state.copyWith(fetchingFares: true);

    try {
      final response = await _repository.getFare(state.subtotal);

      if (response.code == 200) {
        yield state.copyWith(fare: response.data, fetchingFares: false);
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT) {
        yield state.copyWith(
          noInternet: true,
        );
      }
    }
  }
}
