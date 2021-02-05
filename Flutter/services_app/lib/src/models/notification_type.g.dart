// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationType _$serviceFinished =
    const NotificationType._('serviceFinished');
const NotificationType _$serviceStarted =
    const NotificationType._('serviceStarted');
const NotificationType _$unknown = const NotificationType._('unknown');

NotificationType _$notificationTypeValueOf(String name) {
  switch (name) {
    case 'serviceFinished':
      return _$serviceFinished;
    case 'serviceStarted':
      return _$serviceStarted;
    case 'unknown':
      return _$unknown;
    default:
      return _$unknown;
  }
}

final BuiltSet<NotificationType> _$notificationTypeValues =
    new BuiltSet<NotificationType>(const <NotificationType>[
  _$serviceFinished,
  _$serviceStarted,
  _$unknown,
]);

Serializer<NotificationType> _$notificationTypeSerializer =
    new _$NotificationTypeSerializer();

class _$NotificationTypeSerializer
    implements PrimitiveSerializer<NotificationType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'serviceFinished': 'service_finished',
    'serviceStarted': 'service_started',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'service_finished': 'serviceFinished',
    'service_started': 'serviceStarted',
  };

  @override
  final Iterable<Type> types = const <Type>[NotificationType];
  @override
  final String wireName = 'NotificationType';

  @override
  Object serialize(Serializers serializers, NotificationType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NotificationType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NotificationType.valueOf(_fromWire[serialized] ?? serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
