// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NotificationResponse> _$notificationResponseSerializer =
    new _$NotificationResponseSerializer();

class _$NotificationResponseSerializer
    implements StructuredSerializer<NotificationResponse> {
  @override
  final Iterable<Type> types = const [
    NotificationResponse,
    _$NotificationResponse
  ];
  @override
  final String wireName = 'NotificationResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, NotificationResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.notification != null) {
      result
        ..add('notification')
        ..add(serializers.serialize(object.notification,
            specifiedType: const FullType(NotificationModel)));
    }
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(NotificationDataModel)));
    }
    return result;
  }

  @override
  NotificationResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'notification':
          result.notification.replace(serializers.deserialize(value,
                  specifiedType: const FullType(NotificationModel))
              as NotificationModel);
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(NotificationDataModel))
              as NotificationDataModel);
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationResponse extends NotificationResponse {
  @override
  final NotificationModel notification;
  @override
  final NotificationDataModel data;

  factory _$NotificationResponse(
          [void Function(NotificationResponseBuilder) updates]) =>
      (new NotificationResponseBuilder()..update(updates)).build();

  _$NotificationResponse._({this.notification, this.data}) : super._();

  @override
  NotificationResponse rebuild(
          void Function(NotificationResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationResponseBuilder toBuilder() =>
      new NotificationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationResponse &&
        notification == other.notification &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, notification.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NotificationResponse')
          ..add('notification', notification)
          ..add('data', data))
        .toString();
  }
}

class NotificationResponseBuilder
    implements Builder<NotificationResponse, NotificationResponseBuilder> {
  _$NotificationResponse _$v;

  NotificationModelBuilder _notification;
  NotificationModelBuilder get notification =>
      _$this._notification ??= new NotificationModelBuilder();
  set notification(NotificationModelBuilder notification) =>
      _$this._notification = notification;

  NotificationDataModelBuilder _data;
  NotificationDataModelBuilder get data =>
      _$this._data ??= new NotificationDataModelBuilder();
  set data(NotificationDataModelBuilder data) => _$this._data = data;

  NotificationResponseBuilder();

  NotificationResponseBuilder get _$this {
    if (_$v != null) {
      _notification = _$v.notification?.toBuilder();
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NotificationResponse;
  }

  @override
  void update(void Function(NotificationResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NotificationResponse build() {
    _$NotificationResponse _$result;
    try {
      _$result = _$v ??
          new _$NotificationResponse._(
              notification: _notification?.build(), data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'notification';
        _notification?.build();
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NotificationResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
