// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderStatus _$received = const OrderStatus._('received');
const OrderStatus _$unknown = const OrderStatus._('unknown');

OrderStatus _$orderStatusValueOf(String name) {
  switch (name) {
    case 'received':
      return _$received;
    case 'unknown':
      return _$unknown;
    default:
      return _$unknown;
  }
}

final BuiltSet<OrderStatus> _$orderStatusValues =
    new BuiltSet<OrderStatus>(const <OrderStatus>[
  _$received,
  _$unknown,
]);

Serializer<OrderStatus> _$orderStatusSerializer = new _$OrderStatusSerializer();

class _$OrderStatusSerializer implements PrimitiveSerializer<OrderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'received': 'RECIBIDA',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'RECIBIDA': 'received',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderStatus];
  @override
  final String wireName = 'OrderStatus';

  @override
  Object serialize(Serializers serializers, OrderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderStatus.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
