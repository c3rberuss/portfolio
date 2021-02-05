// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PaymentType _$creditCard = const PaymentType._('creditCard');
const PaymentType _$cash = const PaymentType._('cash');

PaymentType _$paymentTypeValueOf(String name) {
  switch (name) {
    case 'creditCard':
      return _$creditCard;
    case 'cash':
      return _$cash;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<PaymentType> _$paymentTypeValues =
    new BuiltSet<PaymentType>(const <PaymentType>[
  _$creditCard,
  _$cash,
]);

Serializer<PaymentType> _$paymentTypeSerializer = new _$PaymentTypeSerializer();

class _$PaymentTypeSerializer implements PrimitiveSerializer<PaymentType> {
  @override
  final Iterable<Type> types = const <Type>[PaymentType];
  @override
  final String wireName = 'PaymentType';

  @override
  Object serialize(Serializers serializers, PaymentType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  PaymentType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PaymentType.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
