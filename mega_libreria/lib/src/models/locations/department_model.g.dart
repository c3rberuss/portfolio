// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DepartmentModel> _$departmentModelSerializer =
    new _$DepartmentModelSerializer();

class _$DepartmentModelSerializer
    implements StructuredSerializer<DepartmentModel> {
  @override
  final Iterable<Type> types = const [DepartmentModel, _$DepartmentModel];
  @override
  final String wireName = 'DepartmentModel';

  @override
  Iterable<Object> serialize(Serializers serializers, DepartmentModel object,
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
  DepartmentModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DepartmentModelBuilder();

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

class _$DepartmentModel extends DepartmentModel {
  @override
  final int id;
  @override
  final String name;

  factory _$DepartmentModel([void Function(DepartmentModelBuilder) updates]) =>
      (new DepartmentModelBuilder()..update(updates)).build();

  _$DepartmentModel._({this.id, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('DepartmentModel', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('DepartmentModel', 'name');
    }
  }

  @override
  DepartmentModel rebuild(void Function(DepartmentModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepartmentModelBuilder toBuilder() =>
      new DepartmentModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepartmentModel && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('DepartmentModel')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class DepartmentModelBuilder
    implements Builder<DepartmentModel, DepartmentModelBuilder> {
  _$DepartmentModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  DepartmentModelBuilder();

  DepartmentModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepartmentModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$DepartmentModel;
  }

  @override
  void update(void Function(DepartmentModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$DepartmentModel build() {
    final _$result = _$v ?? new _$DepartmentModel._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
