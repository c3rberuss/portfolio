// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentIntentResponse> _$paymentIntentResponseSerializer =
    new _$PaymentIntentResponseSerializer();

class _$PaymentIntentResponseSerializer
    implements StructuredSerializer<PaymentIntentResponse> {
  @override
  final Iterable<Type> types = const [
    PaymentIntentResponse,
    _$PaymentIntentResponse
  ];
  @override
  final String wireName = 'PaymentIntentResponse';

  @override
  Iterable<Object> serialize(
      Serializers serializers, PaymentIntentResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount, specifiedType: const FullType(int)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'client_secret',
      serializers.serialize(object.clientSecret,
          specifiedType: const FullType(String)),
      'currency',
      serializers.serialize(object.currency,
          specifiedType: const FullType(String)),
      'created',
      serializers.serialize(object.created, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  PaymentIntentResponse deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentIntentResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'client_secret':
          result.clientSecret = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'created':
          result.created = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentIntentResponse extends PaymentIntentResponse {
  @override
  final int amount;
  @override
  final String id;
  @override
  final String clientSecret;
  @override
  final String currency;
  @override
  final int created;

  factory _$PaymentIntentResponse(
          [void Function(PaymentIntentResponseBuilder) updates]) =>
      (new PaymentIntentResponseBuilder()..update(updates)).build();

  _$PaymentIntentResponse._(
      {this.amount, this.id, this.clientSecret, this.currency, this.created})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('PaymentIntentResponse', 'amount');
    }
    if (id == null) {
      throw new BuiltValueNullFieldError('PaymentIntentResponse', 'id');
    }
    if (clientSecret == null) {
      throw new BuiltValueNullFieldError(
          'PaymentIntentResponse', 'clientSecret');
    }
    if (currency == null) {
      throw new BuiltValueNullFieldError('PaymentIntentResponse', 'currency');
    }
    if (created == null) {
      throw new BuiltValueNullFieldError('PaymentIntentResponse', 'created');
    }
  }

  @override
  PaymentIntentResponse rebuild(
          void Function(PaymentIntentResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentIntentResponseBuilder toBuilder() =>
      new PaymentIntentResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentIntentResponse &&
        amount == other.amount &&
        id == other.id &&
        clientSecret == other.clientSecret &&
        currency == other.currency &&
        created == other.created;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, amount.hashCode), id.hashCode),
                clientSecret.hashCode),
            currency.hashCode),
        created.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentIntentResponse')
          ..add('amount', amount)
          ..add('id', id)
          ..add('clientSecret', clientSecret)
          ..add('currency', currency)
          ..add('created', created))
        .toString();
  }
}

class PaymentIntentResponseBuilder
    implements Builder<PaymentIntentResponse, PaymentIntentResponseBuilder> {
  _$PaymentIntentResponse _$v;

  int _amount;
  int get amount => _$this._amount;
  set amount(int amount) => _$this._amount = amount;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _clientSecret;
  String get clientSecret => _$this._clientSecret;
  set clientSecret(String clientSecret) => _$this._clientSecret = clientSecret;

  String _currency;
  String get currency => _$this._currency;
  set currency(String currency) => _$this._currency = currency;

  int _created;
  int get created => _$this._created;
  set created(int created) => _$this._created = created;

  PaymentIntentResponseBuilder();

  PaymentIntentResponseBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _id = _$v.id;
      _clientSecret = _$v.clientSecret;
      _currency = _$v.currency;
      _created = _$v.created;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentIntentResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentIntentResponse;
  }

  @override
  void update(void Function(PaymentIntentResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentIntentResponse build() {
    final _$result = _$v ??
        new _$PaymentIntentResponse._(
            amount: amount,
            id: id,
            clientSecret: clientSecret,
            currency: currency,
            created: created);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
