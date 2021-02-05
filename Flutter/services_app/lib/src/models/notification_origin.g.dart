// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_origin.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NotificationOrigin _$onMessage = const NotificationOrigin._('onMessage');
const NotificationOrigin _$onResume = const NotificationOrigin._('onResume');
const NotificationOrigin _$onLaunch = const NotificationOrigin._('onLaunch');
const NotificationOrigin _$another = const NotificationOrigin._('another');

NotificationOrigin _$notificationOriginValueOf(String name) {
  switch (name) {
    case 'onMessage':
      return _$onMessage;
    case 'onResume':
      return _$onResume;
    case 'onLaunch':
      return _$onLaunch;
    case 'another':
      return _$another;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<NotificationOrigin> _$notificationOriginValues =
    new BuiltSet<NotificationOrigin>(const <NotificationOrigin>[
  _$onMessage,
  _$onResume,
  _$onLaunch,
  _$another,
]);

Serializer<NotificationOrigin> _$notificationOriginSerializer =
    new _$NotificationOriginSerializer();

class _$NotificationOriginSerializer
    implements PrimitiveSerializer<NotificationOrigin> {
  @override
  final Iterable<Type> types = const <Type>[NotificationOrigin];
  @override
  final String wireName = 'NotificationOrigin';

  @override
  Object serialize(Serializers serializers, NotificationOrigin object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  NotificationOrigin deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NotificationOrigin.valueOf(serialized as String);
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
