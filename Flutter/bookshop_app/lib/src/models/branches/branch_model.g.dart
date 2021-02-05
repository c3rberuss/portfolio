// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BranchModel> _$branchModelSerializer = new _$BranchModelSerializer();

class _$BranchModelSerializer implements StructuredSerializer<BranchModel> {
  @override
  final Iterable<Type> types = const [BranchModel, _$BranchModel];
  @override
  final String wireName = 'BranchModel';

  @override
  Iterable<Object> serialize(Serializers serializers, BranchModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id_empresa',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'id_categoria',
      serializers.serialize(object.idCategory,
          specifiedType: const FullType(int)),
      'estado',
      serializers.serialize(object.status, specifiedType: const FullType(int)),
      'nombre',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'logo',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BranchModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BranchModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id_empresa':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'id_categoria':
          result.idCategory = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'estado':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'nombre':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'logo':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BranchModel extends BranchModel {
  @override
  final int id;
  @override
  final int idCategory;
  @override
  final int status;
  @override
  final String name;
  @override
  final String image;

  factory _$BranchModel([void Function(BranchModelBuilder) updates]) =>
      (new BranchModelBuilder()..update(updates)).build();

  _$BranchModel._(
      {this.id, this.idCategory, this.status, this.name, this.image})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BranchModel', 'id');
    }
    if (idCategory == null) {
      throw new BuiltValueNullFieldError('BranchModel', 'idCategory');
    }
    if (status == null) {
      throw new BuiltValueNullFieldError('BranchModel', 'status');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('BranchModel', 'name');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('BranchModel', 'image');
    }
  }

  @override
  BranchModel rebuild(void Function(BranchModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BranchModelBuilder toBuilder() => new BranchModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BranchModel &&
        id == other.id &&
        idCategory == other.idCategory &&
        status == other.status &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), idCategory.hashCode), status.hashCode),
            name.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BranchModel')
          ..add('id', id)
          ..add('idCategory', idCategory)
          ..add('status', status)
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class BranchModelBuilder implements Builder<BranchModel, BranchModelBuilder> {
  _$BranchModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _idCategory;
  int get idCategory => _$this._idCategory;
  set idCategory(int idCategory) => _$this._idCategory = idCategory;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  BranchModelBuilder();

  BranchModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _idCategory = _$v.idCategory;
      _status = _$v.status;
      _name = _$v.name;
      _image = _$v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BranchModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BranchModel;
  }

  @override
  void update(void Function(BranchModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BranchModel build() {
    final _$result = _$v ??
        new _$BranchModel._(
            id: id,
            idCategory: idCategory,
            status: status,
            name: name,
            image: image);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
