import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_state_model.g.dart';

abstract class OrderStateModel implements Built<OrderStateModel, OrderStateModelBuilder> {
  @BuiltValueField(wireName: 'estado')
  String get state;
  @BuiltValueField(wireName: 'comentario')
  String get comment;
  @BuiltValueField(wireName: 'fecha')
  String get date;
  @BuiltValueField(wireName: 'hora')
  String get time;

  OrderStateModel._();
  factory OrderStateModel([void Function(OrderStateModelBuilder) updates]) = _$OrderStateModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(OrderStateModel.serializer, this);
  }

  static OrderStateModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(OrderStateModel.serializer, json);
  }

  static Serializer<OrderStateModel> get serializer => _$orderStateModelSerializer;
}
