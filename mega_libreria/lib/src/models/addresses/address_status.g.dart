// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AddressStatus _$isPredefined = const AddressStatus._('isPredefined');
const AddressStatus _$isNotPredefined =
    const AddressStatus._('isNotPredefined');

AddressStatus _$addressStatusValueOf(String name) {
  switch (name) {
    case 'isPredefined':
      return _$isPredefined;
    case 'isNotPredefined':
      return _$isNotPredefined;
    default:
      return _$isNotPredefined;
  }
}

final BuiltSet<AddressStatus> _$addressStatusValues =
    new BuiltSet<AddressStatus>(const <AddressStatus>[
  _$isPredefined,
  _$isNotPredefined,
]);

Serializer<AddressStatus> _$addressStatusSerializer =
    new _$AddressStatusSerializer();

class _$AddressStatusSerializer implements PrimitiveSerializer<AddressStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'isPredefined': 1,
    'isNotPredefined': 0,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    1: 'isPredefined',
    0: 'isNotPredefined',
  };

  @override
  final Iterable<Type> types = const <Type>[AddressStatus];
  @override
  final String wireName = 'AddressStatus';

  @override
  Object serialize(Serializers serializers, AddressStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AddressStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AddressStatus.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
