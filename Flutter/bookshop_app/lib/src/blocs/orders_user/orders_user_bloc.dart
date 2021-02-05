import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/models/orders/orders_response.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import './bloc.dart';

class OrdersUserBloc extends Bloc<OrdersUserEvent, OrdersUserState> {
  final UserRepository _repository;

  OrdersUserBloc(this._repository);

  @override
  OrdersUserState get initialState => OrdersUserState.initial();

  @override
  Stream<OrdersUserState> mapEventToState(
    OrdersUserEvent event,
  ) async* {
    if (event is FetchOrdersUserEvent) {
      yield state.copyWith(fetching: true);
      yield* _mapRequest();
    } else if (event is RefreshOrdersUserEvent) {
      yield state.copyWith(refreshingFinalized: false);
      yield* _mapRequest(refresh: true);
    } else if (event is ClearStateEvent) {
      yield OrdersUserState.initial();
    } else if (event is RateOrderEvent) {
      final int rate = event.rate.truncate();

      print("RATE TRUNC $rate");
      _repository.rateOrder(event.orderId, rate);
    }
  }

  Stream<OrdersUserState> _map404() async* {
    yield state.copyWith(
      refreshingFinalized: true,
      fetching: false,
      fetchingFinalized: true,
    );
  }

  Stream<OrdersUserState> _mapRequest({bool refresh = false}) async* {
    try {
      final response = await _repository.getOrders(true);
      if (response.code == 200) {
        if (!refresh) {
          yield* _mapFetch(response);
        } else if (refresh) {
          yield* _mapRefresh(response);
        }
      } else if (response.code == 404) {
        yield* _map404();
      } else {
        print("Session Expired");
      }
    } on DioError catch (error) {
      if (error.type == DioErrorType.DEFAULT) {
        yield state.copyWith(
          noInternet: true,
          fetchingFinalized: false,
          fetching: false,
          refreshingFinalized: false,
        );

        yield state.copyWith(noInternet: false);
      }
    }
  }

  Stream<OrdersUserState> _mapFetch(OrdersResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      orders: response.body,
    );
  }

  Stream<OrdersUserState> _mapRefresh(OrdersResponse response) async* {
    yield state.copyWith(
      refreshingFinalized: true,
      orders: response.body,
    );
  }
}
