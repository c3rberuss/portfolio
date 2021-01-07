// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CityModel> _$cityModelSerializer = new _$CityModelSerializer();

class _$CityModelSerializer implements StructuredSerializer<CityModel> {
  @override
  final Iterable<Type> types = const [CityModel, _$CityModel];
  @override
  final String wireName = 'CityModel';

  @override
  Iterable<Object> serialize(Serializers serializers, CityModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'nombre',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CityModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CityModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nombre':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CityModel extends CityModel {
  @override
  final int id;
  @override
  final String name;

  factory _$CityModel([void Function(CityModelBuilder) updates]) =>
      (new CityModelBuilder()..update(updates)).build();

  _$CityModel._({this.id, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('CityModel', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('CityModel', 'name');
    }
  }

  @override
  CityModel rebuild(void Function(CityModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CityModelBuilder toBuilder() => new CityModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CityModel && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CityModel')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class CityModelBuilder implements Builder<CityModel, CityModelBuilder> {
  _$CityModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  CityModelBuilder();

  CityModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CityModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CityModel;
  }

  @override
  void update(void Function(CityModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CityModel build() {
    final _$result = _$v ?? new _$CityModel._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
