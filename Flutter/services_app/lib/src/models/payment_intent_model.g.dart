// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PaymentIntentModel> _$paymentIntentModelSerializer =
    new _$PaymentIntentModelSerializer();

class _$PaymentIntentModelSerializer
    implements StructuredSerializer<PaymentIntentModel> {
  @override
  final Iterable<Type> types = const [PaymentIntentModel, _$PaymentIntentModel];
  @override
  final String wireName = 'PaymentIntentModel';

  @override
  Iterable<Object> serialize(Serializers serializers, PaymentIntentModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'amount',
      serializers.serialize(object.amount, specifiedType: const FullType(int)),
      'currency',
      serializers.serialize(object.currency,
          specifiedType: const FullType(String)),
      'payment_method',
      serializers.serialize(object.paymentMethod,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PaymentIntentModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaymentIntentModelBuilder();

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
        case 'currency':
          result.currency = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'payment_method':
          result.paymentMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PaymentIntentModel extends PaymentIntentModel {
  @override
  final int amount;
  @override
  final String currency;
  @override
  final String paymentMethod;

  factory _$PaymentIntentModel(
          [void Function(PaymentIntentModelBuilder) updates]) =>
      (new PaymentIntentModelBuilder()..update(updates)).build();

  _$PaymentIntentModel._({this.amount, this.currency, this.paymentMethod})
      : super._() {
    if (amount == null) {
      throw new BuiltValueNullFieldError('PaymentIntentModel', 'amount');
    }
    if (currency == null) {
      throw new BuiltValueNullFieldError('PaymentIntentModel', 'currency');
    }
    if (paymentMethod == null) {
      throw new BuiltValueNullFieldError('PaymentIntentModel', 'paymentMethod');
    }
  }

  @override
  PaymentIntentModel rebuild(
          void Function(PaymentIntentModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentIntentModelBuilder toBuilder() =>
      new PaymentIntentModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentIntentModel &&
        amount == other.amount &&
        currency == other.currency &&
        paymentMethod == other.paymentMethod;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, amount.hashCode), currency.hashCode),
        paymentMethod.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PaymentIntentModel')
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('paymentMethod', paymentMethod))
        .toString();
  }
}

class PaymentIntentModelBuilder
    implements Builder<PaymentIntentModel, PaymentIntentModelBuilder> {
  _$PaymentIntentModel _$v;

  int _amount;
  int get amount => _$this._amount;
  set amount(int amount) => _$this._amount = amount;

  String _currency;
  String get currency => _$this._currency;
  set currency(String currency) => _$this._currency = currency;

  String _paymentMethod;
  String get paymentMethod => _$this._paymentMethod;
  set paymentMethod(String paymentMethod) =>
      _$this._paymentMethod = paymentMethod;

  PaymentIntentModelBuilder();

  PaymentIntentModelBuilder get _$this {
    if (_$v != null) {
      _amount = _$v.amount;
      _currency = _$v.currency;
      _paymentMethod = _$v.paymentMethod;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentIntentModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PaymentIntentModel;
  }

  @override
  void update(void Function(PaymentIntentModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PaymentIntentModel build() {
    final _$result = _$v ??
        new _$PaymentIntentModel._(
            amount: amount, currency: currency, paymentMethod: paymentMethod);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
