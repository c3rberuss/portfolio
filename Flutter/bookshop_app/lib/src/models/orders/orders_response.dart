import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'order_model.dart';

part 'orders_response.g.dart';

abstract class OrdersResponse implements Built<OrdersResponse, OrdersResponseBuilder> {
  int get code;
  String get message;
  @nullable
  @BuiltValueField(wireName: 'data')
  BuiltList<OrderModel> get body;

  OrdersResponse._();
  factory OrdersResponse([void Function(OrdersResponseBuilder) updates]) = _$OrdersResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrdersResponse.serializer, this);
  }

  static OrdersResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrdersResponse.serializer, json);
  }

  static Serializer<OrdersResponse> get serializer => _$ordersResponseSerializer;
}
