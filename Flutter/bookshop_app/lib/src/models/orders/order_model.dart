import 'package:bookshop/src/models/addresses/address_model.dart';
import 'package:bookshop/src/models/orders/payment_type.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'order_detail_model.dart';

part 'order_model.g.dart';

abstract class OrderModel implements Built<OrderModel, OrderModelBuilder> {
/*  {
  "id_orden": 15,
  "fecha": "2020-05-23",
  "hora": "22:19:37",
  "total": 12.5,
  "numero_orden": "L57187228B",
  "detalles": [

  ],
  "cliente": "Josué Amaya",
  "empresa": "THE BURGUER ROCK.",
  "estado": "RECIBIDA"
  }*/
  @nullable
  @BuiltValueField(wireName: 'id_orden')
  int get id;

  @nullable
  @BuiltValueField(wireName: 'fecha')
  String get date;

  @nullable
  @BuiltValueField(wireName: 'hora')
  String get time;

  double get total;

  @nullable
  @BuiltValueField(wireName: 'numero_orden')
  String get orderNumber;

  @BuiltValueField(wireName: 'detalles')
  BuiltList<OrderDetailModel> get detail;

  @nullable
  @BuiltValueField(wireName: 'estado')
  String get status;

  @nullable
  @BuiltValueField(wireName: 'envio')
  double get fareDelivery;

  @nullable
  @BuiltValueField(wireName: 'tipo_pago')
  PaymentType get paymentType;

  @nullable
  @BuiltValueField(wireName: 'dirección')
  AddressModel get address;

  @nullable
  @BuiltValueField(wireName: 'id_direccion')
  int get addressId;

  @nullable
  @BuiltValueField(wireName: 'id_empresa')
  int get companyId;

  @nullable
  @BuiltValueField(wireName: 'empresa')
  String get company;

  OrderModel._();

  factory OrderModel([void Function(OrderModelBuilder) updates]) = _$OrderModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrderModel.serializer, this);
  }

  static OrderModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrderModel.serializer, json);
  }

  static Serializer<OrderModel> get serializer => _$orderModelSerializer;
}
