// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_status_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ApplicationStatusModel _$unpaid =
    const ApplicationStatusModel._('unpaid');
const ApplicationStatusModel _$paid = const ApplicationStatusModel._('paid');
const ApplicationStatusModel _$partialPaid =
    const ApplicationStatusModel._('partialPaid');
const ApplicationStatusModel _$cancelled =
    const ApplicationStatusModel._('cancelled');

ApplicationStatusModel _$applicationStatusModelValueOf(String name) {
  switch (name) {
    case 'unpaid':
      return _$unpaid;
    case 'paid':
      return _$paid;
    case 'partialPaid':
      return _$partialPaid;
    case 'cancelled':
      return _$cancelled;
    default:
      return _$unpaid;
  }
}

final BuiltSet<ApplicationStatusModel> _$applicationStatusModelValues =
    new BuiltSet<ApplicationStatusModel>(const <ApplicationStatusModel>[
  _$unpaid,
  _$paid,
  _$partialPaid,
  _$cancelled,
]);

Serializer<ApplicationStatusModel> _$applicationStatusModelSerializer =
    new _$ApplicationStatusModelSerializer();

class _$ApplicationStatusModelSerializer
    implements PrimitiveSerializer<ApplicationStatusModel> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unpaid': 'unpaid',
    'paid': 'paid',
    'partialPaid': 'partial_paid',
    'cancelled': 'cancelled',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unpaid': 'unpaid',
    'paid': 'paid',
    'partial_paid': 'partialPaid',
    'cancelled': 'cancelled',
  };

  @override
  final Iterable<Type> types = const <Type>[ApplicationStatusModel];
  @override
  final String wireName = 'ApplicationStatusModel';

  @override
  Object serialize(Serializers serializers, ApplicationStatusModel object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ApplicationStatusModel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ApplicationStatusModel.valueOf(
          _fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
