import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'order_detail_model.g.dart';

abstract class OrderDetailModel implements Built<OrderDetailModel, OrderDetailModelBuilder> {
/*
  "id_producto": "id",
  "cantidad": "cantidad",
  "precio": "precio",
  "subtotal": "subtotal",
*/

  @nullable
  @BuiltValueField(wireName: 'id_detalle')
  int get id;

  @BuiltValueField(wireName: 'cantidad')
  int get quantity;

  @BuiltValueField(wireName: 'precio')
  double get price;

  double get subtotal;

  @nullable
  @BuiltValueField(wireName: 'id_producto')
  int get productId;

  @nullable
  @BuiltValueField(wireName: 'producto')
  String get name;

  @nullable
  @BuiltValueField(wireName: 'imagen')
  String get image;

  OrderDetailModel._();

  factory OrderDetailModel([void Function(OrderDetailModelBuilder) updates]) = _$OrderDetailModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrderDetailModel.serializer, this);
  }

  static OrderDetailModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrderDetailModel.serializer, json);
  }

  static Serializer<OrderDetailModel> get serializer => _$orderDetailModelSerializer;
}
