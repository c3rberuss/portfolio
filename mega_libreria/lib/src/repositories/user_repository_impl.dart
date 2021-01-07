import 'package:megalibreria/src/models/orders/fare_response.dart';
import 'package:megalibreria/src/models/orders/order_model.dart';
import 'package:megalibreria/src/models/orders/order_states_response.dart';
import 'package:megalibreria/src/models/orders/orders_response.dart';
import 'package:megalibreria/src/models/response.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/models/users/user_response.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';

import 'network_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkRepository _network;

  UserRepositoryImpl(this._network);

  @override
  Future<UserResponse> register(Map<String, dynamic> user) async {
    final response = await _network.instance.post(
      "/clientes/api/register",
      data: user,
    );
    return UserResponse.fromJson(response.data);
  }

  @override
  Future<UserResponse> update(UserModel user) async {
    final response = await _network.instance.patch(
      "/clientes/api/update",
      data: user.toJson(),
    );

    return UserResponse.fromJson(response.data);
  }

  @override
  Future<UserResponse> recoveryPassword(String email) async {
    return null;
  }

  @override
  Future<UserResponse> setPassword(String oldPassword, String newPassword) async {
    final response = await _network.instance.patch(
      "/clientes/api/password",
      data: {
        "password_actual": oldPassword,
        "password": newPassword,
      },
    );

    return UserResponse.fromJson(response.data);
  }

  @override
  Future<Response> createOrder(OrderModel order) async {
    final response = await _network.instance.post(
      "/ordenes/api",
      data: order.toJson(),
    );

    return Response.fromJson(response.data);
  }

  @override
  Future<FareResponse> getFare(double total) async {
    final response = await _network.instance.post("/ordenes/api/tarifa", data: {"total": total});
    return FareResponse.fromJson(response.data);
  }

  @override
  Future<OrdersResponse> getOrders([bool refresh = false]) async {
    final response = await _network.instance.get("/ordenes/api/");

    return OrdersResponse.fromJson(response.data);
  }

  @override
  Future<OrderStatesResponse> getRecord(int orderId, [bool refresh = false]) async {
    final response = await _network.instance.get("/ordenes/api/seguimiento/$orderId");
    return OrderStatesResponse.fromJson(response.data);
  }

  @override
  Future<Response> rateOrder(int orderId, int rate) async {
    final response = await _network.instance.patch("/clientes/api/calificacion", data: {
      "id": orderId,
      "calificacion": rate,
    });

    print(response.data);

    return Response.fromJson(response.data);
  }

  @override
  Future<Response> addToWishList(int id) async {
    final response = await _network.instance.post("/clientes/api/wishlist/add", data: {"id": id});
    return Response.fromJson(response.data);
  }

  @override
  Future<Response> fetchWishList() {
    // TODO: implement fetchWishList
    throw UnimplementedError();
  }

  @override
  Future<Response> removeFromWishList(int id) async {
    final response = await _network.instance.post("/clientes/api/wishlist/remove", data: {"id": id});
    return Response.fromJson(response.data);
  }
}
