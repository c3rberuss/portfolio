import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_status.g.dart';

class OrderStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: 'RECIBIDA')
  static const OrderStatus received = _$received;

  @BuiltValueEnumConst(fallback: true)
  static const OrderStatus unknown = _$unknown;

  const OrderStatus._(String name) : super(name);

  static BuiltSet<OrderStatus> get values => _$orderStatusValues;
  static OrderStatus valueOf(String name) => _$orderStatusValueOf(name);

  String serialize() {
    return serializers.serializeWith(OrderStatus.serializer, this);
  }

  static OrderStatus deserialize(String string) {
    return serializers.deserializeWith(OrderStatus.serializer, string);
  }

  static Serializer<OrderStatus> get serializer => _$orderStatusSerializer;
}
