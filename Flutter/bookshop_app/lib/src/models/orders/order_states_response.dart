import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'order_state_model.dart';

part 'order_states_response.g.dart';

abstract class OrderStatesResponse
    implements Built<OrderStatesResponse, OrderStatesResponseBuilder> {
  int get code;
  String get message;

  @nullable
  BuiltList<OrderStateModel> get data;

  OrderStatesResponse._();
  factory OrderStatesResponse([void Function(OrderStatesResponseBuilder) updates]) =
      _$OrderStatesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrderStatesResponse.serializer, this);
  }

  static OrderStatesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrderStatesResponse.serializer, json);
  }

  static Serializer<OrderStatesResponse> get serializer => _$orderStatesResponseSerializer;
}
