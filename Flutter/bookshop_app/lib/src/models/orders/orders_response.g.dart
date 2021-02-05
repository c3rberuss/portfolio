// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrdersResponse> _$ordersResponseSerializer =
    new _$OrdersResponseSerializer();

class _$OrdersResponseSerializer
    implements StructuredSerializer<OrdersResponse> {
  @override
  final Iterable<Type> types = const [OrdersResponse, _$OrdersResponse];
  @override
  final String wireName = 'OrdersResponse';

  @override
  Iterable<Object> serialize(Serializers serializers, OrdersResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'code',
      serializers.serialize(object.code, specifiedType: const FullType(int)),
      'message',
      serializers.serialize(object.message,
          specifiedType: const FullType(String)),
    ];
    if (object.body != null) {
      result
        ..add('data')
        ..add(serializers.serialize(object.body,
            specifiedType:
                const FullType(BuiltList, const [const FullType(OrderModel)])));
    }
    return result;
  }

  @override
  OrdersResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrdersResponseBuilder();

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
          result.body.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(OrderModel)]))
              as BuiltList<Object>);
          break;
      }
    }

    return result.build();
  }
}

class _$OrdersResponse extends OrdersResponse {
  @override
  final int code;
  @override
  final String message;
  @override
  final BuiltList<OrderModel> body;

  factory _$OrdersResponse([void Function(OrdersResponseBuilder) updates]) =>
      (new OrdersResponseBuilder()..update(updates)).build();

  _$OrdersResponse._({this.code, this.message, this.body}) : super._() {
    if (code == null) {
      throw new BuiltValueNullFieldError('OrdersResponse', 'code');
    }
    if (message == null) {
      throw new BuiltValueNullFieldError('OrdersResponse', 'message');
    }
  }

  @override
  OrdersResponse rebuild(void Function(OrdersResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrdersResponseBuilder toBuilder() =>
      new OrdersResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrdersResponse &&
        code == other.code &&
        message == other.message &&
        body == other.body;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, code.hashCode), message.hashCode), body.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrdersResponse')
          ..add('code', code)
          ..add('message', message)
          ..add('body', body))
        .toString();
  }
}

class OrdersResponseBuilder
    implements Builder<OrdersResponse, OrdersResponseBuilder> {
  _$OrdersResponse _$v;

  int _code;
  int get code => _$this._code;
  set code(int code) => _$this._code = code;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  ListBuilder<OrderModel> _body;
  ListBuilder<OrderModel> get body =>
      _$this._body ??= new ListBuilder<OrderModel>();
  set body(ListBuilder<OrderModel> body) => _$this._body = body;

  OrdersResponseBuilder();

  OrdersResponseBuilder get _$this {
    if (_$v != null) {
      _code = _$v.code;
      _message = _$v.message;
      _body = _$v.body?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrdersResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrdersResponse;
  }

  @override
  void update(void Function(OrdersResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrdersResponse build() {
    _$OrdersResponse _$result;
    try {
      _$result = _$v ??
          new _$OrdersResponse._(
              code: code, message: message, body: _body?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'body';
        _body?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrdersResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
