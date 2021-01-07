// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FareModel> _$fareModelSerializer = new _$FareModelSerializer();

class _$FareModelSerializer implements StructuredSerializer<FareModel> {
  @override
  final Iterable<Type> types = const [FareModel, _$FareModel];
  @override
  final String wireName = 'FareModel';

  @override
  Iterable<Object> serialize(Serializers serializers, FareModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'total',
      serializers.serialize(object.total,
          specifiedType: const FullType(double)),
      'tarifa',
      serializers.serialize(object.fare, specifiedType: const FullType(double)),
      'minimo',
      serializers.serialize(object.minimum,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  FareModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FareModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tarifa':
          result.fare = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'minimo':
          result.minimum = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$FareModel extends FareModel {
  @override
  final double total;
  @override
  final double fare;
  @override
  final double minimum;

  factory _$FareModel([void Function(FareModelBuilder) updates]) =>
      (new FareModelBuilder()..update(updates)).build();

  _$FareModel._({this.total, this.fare, this.minimum}) : super._() {
    if (total == null) {
      throw new BuiltValueNullFieldError('FareModel', 'total');
    }
    if (fare == null) {
      throw new BuiltValueNullFieldError('FareModel', 'fare');
    }
    if (minimum == null) {
      throw new BuiltValueNullFieldError('FareModel', 'minimum');
    }
  }

  @override
  FareModel rebuild(void Function(FareModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FareModelBuilder toBuilder() => new FareModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FareModel &&
        total == other.total &&
        fare == other.fare &&
        minimum == other.minimum;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, total.hashCode), fare.hashCode), minimum.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FareModel')
          ..add('total', total)
          ..add('fare', fare)
          ..add('minimum', minimum))
        .toString();
  }
}

class FareModelBuilder implements Builder<FareModel, FareModelBuilder> {
  _$FareModel _$v;

  double _total;
  double get total => _$this._total;
  set total(double total) => _$this._total = total;

  double _fare;
  double get fare => _$this._fare;
  set fare(double fare) => _$this._fare = fare;

  double _minimum;
  double get minimum => _$this._minimum;
  set minimum(double minimum) => _$this._minimum = minimum;

  FareModelBuilder();

  FareModelBuilder get _$this {
    if (_$v != null) {
      _total = _$v.total;
      _fare = _$v.fare;
      _minimum = _$v.minimum;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FareModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FareModel;
  }

  @override
  void update(void Function(FareModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FareModel build() {
    final _$result =
        _$v ?? new _$FareModel._(total: total, fare: fare, minimum: minimum);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
