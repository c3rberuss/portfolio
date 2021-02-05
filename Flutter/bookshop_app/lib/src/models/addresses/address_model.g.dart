// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddressModel> _$addressModelSerializer =
    new _$AddressModelSerializer();

class _$AddressModelSerializer implements StructuredSerializer<AddressModel> {
  @override
  final Iterable<Type> types = const [AddressModel, _$AddressModel];
  @override
  final String wireName = 'AddressModel';

  @override
  Iterable<Object> serialize(Serializers serializers, AddressModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'direccion',
      serializers.serialize(object.address,
          specifiedType: const FullType(String)),
    ];
    if (object.latitude != null) {
      result
        ..add('latitud')
        ..add(serializers.serialize(object.latitude,
            specifiedType: const FullType(double)));
    }
    if (object.longitude != null) {
      result
        ..add('longitud')
        ..add(serializers.serialize(object.longitude,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  AddressModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddressModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'direccion':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'latitud':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'longitud':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$AddressModel extends AddressModel {
  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;

  factory _$AddressModel([void Function(AddressModelBuilder) updates]) =>
      (new AddressModelBuilder()..update(updates)).build();

  _$AddressModel._({this.address, this.latitude, this.longitude}) : super._() {
    if (address == null) {
      throw new BuiltValueNullFieldError('AddressModel', 'address');
    }
  }

  @override
  AddressModel rebuild(void Function(AddressModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddressModelBuilder toBuilder() => new AddressModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddressModel &&
        address == other.address &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, address.hashCode), latitude.hashCode), longitude.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AddressModel')
          ..add('address', address)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class AddressModelBuilder
    implements Builder<AddressModel, AddressModelBuilder> {
  _$AddressModel _$v;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  AddressModelBuilder();

  AddressModelBuilder get _$this {
    if (_$v != null) {
      _address = _$v.address;
      _latitude = _$v.latitude;
      _longitude = _$v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddressModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AddressModel;
  }

  @override
  void update(void Function(AddressModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AddressModel build() {
    final _$result = _$v ??
        new _$AddressModel._(
            address: address, latitude: latitude, longitude: longitude);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
