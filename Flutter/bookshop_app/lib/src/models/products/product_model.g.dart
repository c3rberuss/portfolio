// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ProductModel> _$productModelSerializer =
    new _$ProductModelSerializer();

class _$ProductModelSerializer implements StructuredSerializer<ProductModel> {
  @override
  final Iterable<Type> types = const [ProductModel, _$ProductModel];
  @override
  final String wireName = 'ProductModel';

  @override
  Iterable<Object> serialize(Serializers serializers, ProductModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'marca',
      serializers.serialize(object.brand,
          specifiedType: const FullType(String)),
      'nombre',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'descripcion',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'imagen',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'thumb1',
      serializers.serialize(object.thumb,
          specifiedType: const FullType(String)),
      'precio',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
    ];
    if (object.stock != null) {
      result
        ..add('stock')
        ..add(serializers.serialize(object.stock,
            specifiedType: const FullType(int)));
    }
    if (object.type != null) {
      result
        ..add('tipo')
        ..add(serializers.serialize(object.type,
            specifiedType: const FullType(ProductType)));
    }
    return result;
  }

  @override
  ProductModel deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProductModelBuilder();

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
        case 'marca':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nombre':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'descripcion':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imagen':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumb1':
          result.thumb = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'precio':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'stock':
          result.stock = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tipo':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(ProductType)) as ProductType;
          break;
      }
    }

    return result.build();
  }
}

class _$ProductModel extends ProductModel {
  @override
  final int id;
  @override
  final String brand;
  @override
  final String name;
  @override
  final String description;
  @override
  final String image;
  @override
  final String thumb;
  @override
  final double price;
  @override
  final int stock;
  @override
  final ProductType type;

  factory _$ProductModel([void Function(ProductModelBuilder) updates]) =>
      (new ProductModelBuilder()..update(updates)).build();

  _$ProductModel._(
      {this.id,
      this.brand,
      this.name,
      this.description,
      this.image,
      this.thumb,
      this.price,
      this.stock,
      this.type})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'id');
    }
    if (brand == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'brand');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'name');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'description');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'image');
    }
    if (thumb == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'thumb');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('ProductModel', 'price');
    }
  }

  @override
  ProductModel rebuild(void Function(ProductModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProductModelBuilder toBuilder() => new ProductModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProductModel &&
        id == other.id &&
        brand == other.brand &&
        name == other.name &&
        description == other.description &&
        image == other.image &&
        thumb == other.thumb &&
        price == other.price &&
        stock == other.stock &&
        type == other.type;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc($jc(0, id.hashCode), brand.hashCode),
                                name.hashCode),
                            description.hashCode),
                        image.hashCode),
                    thumb.hashCode),
                price.hashCode),
            stock.hashCode),
        type.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ProductModel')
          ..add('id', id)
          ..add('brand', brand)
          ..add('name', name)
          ..add('description', description)
          ..add('image', image)
          ..add('thumb', thumb)
          ..add('price', price)
          ..add('stock', stock)
          ..add('type', type))
        .toString();
  }
}

class ProductModelBuilder
    implements Builder<ProductModel, ProductModelBuilder> {
  _$ProductModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _brand;
  String get brand => _$this._brand;
  set brand(String brand) => _$this._brand = brand;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  String _thumb;
  String get thumb => _$this._thumb;
  set thumb(String thumb) => _$this._thumb = thumb;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  int _stock;
  int get stock => _$this._stock;
  set stock(int stock) => _$this._stock = stock;

  ProductType _type;
  ProductType get type => _$this._type;
  set type(ProductType type) => _$this._type = type;

  ProductModelBuilder();

  ProductModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _brand = _$v.brand;
      _name = _$v.name;
      _description = _$v.description;
      _image = _$v.image;
      _thumb = _$v.thumb;
      _price = _$v.price;
      _stock = _$v.stock;
      _type = _$v.type;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProductModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProductModel;
  }

  @override
  void update(void Function(ProductModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProductModel build() {
    final _$result = _$v ??
        new _$ProductModel._(
            id: id,
            brand: brand,
            name: name,
            description: description,
            image: image,
            thumb: thumb,
            price: price,
            stock: stock,
            type: type);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
