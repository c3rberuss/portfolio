// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ProductType _$virtual = const ProductType._('virtual');
const ProductType _$physical = const ProductType._('physical');

ProductType _$productTypeValueOf(String name) {
  switch (name) {
    case 'virtual':
      return _$virtual;
    case 'physical':
      return _$physical;
    default:
      return _$physical;
  }
}

final BuiltSet<ProductType> _$productTypeValues =
    new BuiltSet<ProductType>(const <ProductType>[
  _$virtual,
  _$physical,
]);

Serializer<ProductType> _$productTypeSerializer = new _$ProductTypeSerializer();

class _$ProductTypeSerializer implements PrimitiveSerializer<ProductType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'virtual': 'VIRTUAL',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'VIRTUAL': 'virtual',
  };

  @override
  final Iterable<Type> types = const <Type>[ProductType];
  @override
  final String wireName = 'ProductType';

  @override
  Object serialize(Serializers serializers, ProductType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ProductType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ProductType.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
