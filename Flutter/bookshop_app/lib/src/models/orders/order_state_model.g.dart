// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_state_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderStateModel> _$orderStateModelSerializer =
    new _$OrderStateModelSerializer();

class _$OrderStateModelSerializer
    implements StructuredSerializer<OrderStateModel> {
  @override
  final Iterable<Type> types = const [OrderStateModel, _$OrderStateModel];
  @override
  final String wireName = 'OrderStateModel';

  @override
  Iterable<Object> serialize(Serializers serializers, OrderStateModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'estado',
      serializers.serialize(object.state,
          specifiedType: const FullType(String)),
      'comentario',
      serializers.serialize(object.comment,
          specifiedType: const FullType(String)),
      'fecha',
      serializers.serialize(object.date, specifiedType: const FullType(String)),
      'hora',
      serializers.serialize(object.time, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  OrderStateModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderStateModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'estado':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'comentario':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fecha':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'hora':
          result.time = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OrderStateModel extends OrderStateModel {
  @override
  final String state;
  @override
  final String comment;
  @override
  final String date;
  @override
  final String time;

  factory _$OrderStateModel([void Function(OrderStateModelBuilder) updates]) =>
      (new OrderStateModelBuilder()..update(updates)).build();

  _$OrderStateModel._({this.state, this.comment, this.date, this.time})
      : super._() {
    if (state == null) {
      throw new BuiltValueNullFieldError('OrderStateModel', 'state');
    }
    if (comment == null) {
      throw new BuiltValueNullFieldError('OrderStateModel', 'comment');
    }
    if (date == null) {
      throw new BuiltValueNullFieldError('OrderStateModel', 'date');
    }
    if (time == null) {
      throw new BuiltValueNullFieldError('OrderStateModel', 'time');
    }
  }

  @override
  OrderStateModel rebuild(void Function(OrderStateModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderStateModelBuilder toBuilder() =>
      new OrderStateModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderStateModel &&
        state == other.state &&
        comment == other.comment &&
        date == other.date &&
        time == other.time;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, state.hashCode), comment.hashCode), date.hashCode),
        time.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderStateModel')
          ..add('state', state)
          ..add('comment', comment)
          ..add('date', date)
          ..add('time', time))
        .toString();
  }
}

class OrderStateModelBuilder
    implements Builder<OrderStateModel, OrderStateModelBuilder> {
  _$OrderStateModel _$v;

  String _state;
  String get state => _$this._state;
  set state(String state) => _$this._state = state;

  String _comment;
  String get comment => _$this._comment;
  set comment(String comment) => _$this._comment = comment;

  String _date;
  String get date => _$this._date;
  set date(String date) => _$this._date = date;

  String _time;
  String get time => _$this._time;
  set time(String time) => _$this._time = time;

  OrderStateModelBuilder();

  OrderStateModelBuilder get _$this {
    if (_$v != null) {
      _state = _$v.state;
      _comment = _$v.comment;
      _date = _$v.date;
      _time = _$v.time;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderStateModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrderStateModel;
  }

  @override
  void update(void Function(OrderStateModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderStateModel build() {
    final _$result = _$v ??
        new _$OrderStateModel._(
            state: state, comment: comment, date: date, time: time);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
