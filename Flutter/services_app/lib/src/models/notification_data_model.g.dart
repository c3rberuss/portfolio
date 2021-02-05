// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NotificationDataModel> _$notificationDataModelSerializer =
    new _$NotificationDataModelSerializer();

class _$NotificationDataModelSerializer
    implements StructuredSerializer<NotificationDataModel> {
  @override
  final Iterable<Type> types = const [
    NotificationDataModel,
    _$NotificationDataModel
  ];
  @override
  final String wireName = 'NotificationDataModel';

  @override
  Iterable<Object> serialize(
      Serializers serializers, NotificationDataModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.applicationId != null) {
      result
        ..add('application_id')
        ..add(serializers.serialize(object.applicationId,
            specifiedType: const FullType(String)));
    }
    if (object.notificationType != null) {
      result
        ..add('notification_type')
        ..add(serializers.serialize(object.notificationType,
            specifiedType: const FullType(NotificationType)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.body != null) {
      result
        ..add('body')
        ..add(serializers.serialize(object.body,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  NotificationDataModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NotificationDataModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'application_id':
          result.applicationId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'notification_type':
          result.notificationType = serializers.deserialize(value,
                  specifiedType: const FullType(NotificationType))
              as NotificationType;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$NotificationDataModel extends NotificationDataModel {
  @override
  final String applicationId;
  @override
  final NotificationType notificationType;
  @override
  final String title;
  @override
  final String body;

  factory _$NotificationDataModel(
          [void Function(NotificationDataModelBuilder) updates]) =>
      (new NotificationDataModelBuilder()..update(updates)).build();

  _$NotificationDataModel._(
      {this.applicationId, this.notificationType, this.title, this.body})
      : super._();

  @override
  NotificationDataModel rebuild(
          void Function(NotificationDataModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationDataModelBuilder toBuilder() =>
      new NotificationDataModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationDataModel &&
        applicationId == other.applicationId &&
        notificationType == other.notificationType &&
        title == other.title &&
        body == other.body;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, applicationId.hashCode), notificationType.hashCode),
            title.hashCode),
        body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NotificationDataModel')
          ..add('applicationId', applicationId)
          ..add('notificationType', notificationType)
          ..add('title', title)
          ..add('body', body))
        .toString();
  }
}

class NotificationDataModelBuilder
    implements Builder<NotificationDataModel, NotificationDataModelBuilder> {
  _$NotificationDataModel _$v;

  String _applicationId;
  String get applicationId => _$this._applicationId;
  set applicationId(String applicationId) =>
      _$this._applicationId = applicationId;

  NotificationType _notificationType;
  NotificationType get notificationType => _$this._notificationType;
  set notificationType(NotificationType notificationType) =>
      _$this._notificationType = notificationType;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  NotificationDataModelBuilder();

  NotificationDataModelBuilder get _$this {
    if (_$v != null) {
      _applicationId = _$v.applicationId;
      _notificationType = _$v.notificationType;
      _title = _$v.title;
      _body = _$v.body;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationDataModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$NotificationDataModel;
  }

  @override
  void update(void Function(NotificationDataModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NotificationDataModel build() {
    final _$result = _$v ??
        new _$NotificationDataModel._(
            applicationId: applicationId,
            notificationType: notificationType,
            title: title,
            body: body);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
