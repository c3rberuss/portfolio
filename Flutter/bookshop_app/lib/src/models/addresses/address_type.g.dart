// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AddressType _$delivery = const AddressType._('delivery');
const AddressType _$shipping = const AddressType._('shipping');
const AddressType _$unknown = const AddressType._('unknown');

AddressType _$addressTypeValueOf(String name) {
  switch (name) {
    case 'delivery':
      return _$delivery;
    case 'shipping':
      return _$shipping;
    case 'unknown':
      return _$unknown;
    default:
      return _$unknown;
  }
}

final BuiltSet<AddressType> _$addressTypeValues =
    new BuiltSet<AddressType>(const <AddressType>[
  _$delivery,
  _$shipping,
  _$unknown,
]);

Serializer<AddressType> _$addressTypeSerializer = new _$AddressTypeSerializer();

class _$AddressTypeSerializer implements PrimitiveSerializer<AddressType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'delivery': 0,
    'shipping': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'delivery',
    1: 'shipping',
  };

  @override
  final Iterable<Type> types = const <Type>[AddressType];
  @override
  final String wireName = 'AddressType';

  @override
  Object serialize(Serializers serializers, AddressType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AddressType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AddressType.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
