// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_states_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderStatesResponse> _$orderStatesResponseSerializer =
    new _$OrderStatesResponseSerializer();

class _$OrderStatesResponseSerializer
    implements StructuredSerializer<OrderStatesResponse> {
  @override
  final Iterable<Type> types = const [
    OrderStatesResponse,
    _$OrderStatesResponse
  ];
  @override
  final String wireName = 'OrderStatesResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, OrderStatesResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.data != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.data,
            specifiedType: const FullType(
                BuiltList, const [const FullType(OrderStateModel)])));
    }
    return result;
  }

  @override
  OrderStatesResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderStatesResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(OrderStateModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$OrderStatesResponse extends OrderStatesResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<OrderStateModel> data;

  factory _$OrderStatesResponse(
          [void Function(OrderStatesResponseBuilder) updates]) =>
      (new OrderStatesResponseBuilder()..update(updates)).build();

  _$OrderStatesResponse._({this.code, this.message, this.data}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('OrderStatesResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('OrderStatesResponse', 'message');
    }
  }

  @override
  OrderStatesResponse rebuild(
          void Function(OrderStatesResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderStatesResponseBuilder toBuilder() =>
      new OrderStatesResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderStatesResponse &&
        code == other.code &&
        message == other.message &&
        data == other.data;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, code.hashCode), message.hashCode), data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderStatesResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('data', data))
        .toString();
  }
}

class OrderStatesResponseBuilder
    implements Builder<OrderStatesResponse, OrderStatesResponseBuilder> {
  _$OrderStatesResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<OrderStateModel> _data;
  ListBuilder<OrderStateModel> get data =>
      _$this._data ??= new ListBuilder<OrderStateModel>();
  set data(ListBuilder<OrderStateModel> data) => _$this._data = data;

  OrderStatesResponseBuilder();

  OrderStatesResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderStatesResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrderStatesResponse;
  }

  @override
  void update(void Function(OrderStatesResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderStatesResponse build() {
    _$OrderStatesResponse _$result;
    try {
      _$result = _$v ??
          new _$OrderStatesResponse._(
              code: code, message: message, data: _data?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        _data?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrderStatesResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
