import 'dart:async';

import 'package:bookshop/src/models/orders/fare_response.dart';
import 'package:bookshop/src/models/orders/order_model.dart';
import 'package:bookshop/src/models/orders/order_states_response.dart';
import 'package:bookshop/src/models/orders/orders_response.dart';
import 'package:bookshop/src/models/response.dart';
import 'package:bookshop/src/models/users/user_model.dart';
import 'package:bookshop/src/models/users/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> register(Map<String, dynamic> user);
  Future<UserResponse> update(UserModel user);
  Future<UserResponse> recoveryPassword(String email);
  Future<UserResponse> setPassword(String oldPassword, String newPassword);
  Future<Response> createOrder(OrderModel order);
  Future<FareResponse> getFare(double total);
  Future<OrdersResponse> getOrders([bool refresh = false]);
  Future<OrderStatesResponse> getRecord(int orderId, [bool refresh = false]);
  Future<Response> rateOrder(int orderId, int rate);
  Future<Response> addToWishList(int id);
  Future<Response> removeFromWishList(int id);
  Future<Response> fetchWishList();
}
