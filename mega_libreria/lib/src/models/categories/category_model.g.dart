// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CategoryModel> _$categoryModelSerializer =
    new _$CategoryModelSerializer();

class _$CategoryModelSerializer implements StructuredSerializer<CategoryModel> {
  @override
  final Iterable<Type> types = const [CategoryModel, _$CategoryModel];
  @override
  final String wireName = 'CategoryModel';

  @override
  Iterable<Object> serialize(Serializers serializers, CategoryModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'nombre',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'imagen',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  CategoryModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategoryModelBuilder();

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
        case 'imagen':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CategoryModel extends CategoryModel {
  @override
  final int id;
  @override
  final String name;
  @override
  final String image;

  factory _$CategoryModel([void Function(CategoryModelBuilder) updates]) =>
      (new CategoryModelBuilder()..update(updates)).build();

  _$CategoryModel._({this.id, this.name, this.image}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('CategoryModel', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('CategoryModel', 'name');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('CategoryModel', 'image');
    }
  }

  @override
  CategoryModel rebuild(void Function(CategoryModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryModelBuilder toBuilder() => new CategoryModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoryModel &&
        id == other.id &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, id.hashCode), name.hashCode), image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CategoryModel')
          ..add('id', id)
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class CategoryModelBuilder
    implements Builder<CategoryModel, CategoryModelBuilder> {
  _$CategoryModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  CategoryModelBuilder();

  CategoryModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _image = _$v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoryModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CategoryModel;
  }

  @override
  void update(void Function(CategoryModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CategoryModel build() {
    final _$result =
        _$v ?? new _$CategoryModel._(id: id, name: name, image: image);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
