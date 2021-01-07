// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderDetailModel> _$orderDetailModelSerializer =
    new _$OrderDetailModelSerializer();

class _$OrderDetailModelSerializer
    implements StructuredSerializer<OrderDetailModel> {
  @override
  final Iterable<Type> types = const [OrderDetailModel, _$OrderDetailModel];
  @override
  final String wireName = 'OrderDetailModel';

  @override
  Iterable<Object> serialize(Serializers serializers, OrderDetailModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'cantidad',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(int)),
      'precio',
      serializers.serialize(object.price,
          specifiedType: const FullType(double)),
      'subtotal',
      serializers.serialize(object.subtotal,
          specifiedType: const FullType(double)),
    ];
    if (object.id != null) {
      result
        ..add('id_detalle')
        ..add(serializers.serialize(object.id,
            specifiedType: const FullType(int)));
    }
    if (object.productId != null) {
      result
        ..add('id_producto')
        ..add(serializers.serialize(object.productId,
            specifiedType: const FullType(int)));
    }
    if (object.name != null) {
      result
        ..add('producto')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.image != null) {
      result
        ..add('imagen')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OrderDetailModel deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderDetailModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id_detalle':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'cantidad':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'precio':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'subtotal':
          result.subtotal = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'id_producto':
          result.productId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'producto':
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

class _$OrderDetailModel extends OrderDetailModel {
  @override
  final int id;
  @override
  final int quantity;
  @override
  final double price;
  @override
  final double subtotal;
  @override
  final int productId;
  @override
  final String name;
  @override
  final String image;

  factory _$OrderDetailModel(
          [void Function(OrderDetailModelBuilder) updates]) =>
      (new OrderDetailModelBuilder()..update(updates)).build();

  _$OrderDetailModel._(
      {this.id,
      this.quantity,
      this.price,
      this.subtotal,
      this.productId,
      this.name,
      this.image})
      : super._() {
    if (quantity == null) {
      throw new BuiltValueNullFieldError('OrderDetailModel', 'quantity');
    }
    if (price == null) {
      throw new BuiltValueNullFieldError('OrderDetailModel', 'price');
    }
    if (subtotal == null) {
      throw new BuiltValueNullFieldError('OrderDetailModel', 'subtotal');
    }
  }

  @override
  OrderDetailModel rebuild(void Function(OrderDetailModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderDetailModelBuilder toBuilder() =>
      new OrderDetailModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderDetailModel &&
        id == other.id &&
        quantity == other.quantity &&
        price == other.price &&
        subtotal == other.subtotal &&
        productId == other.productId &&
        name == other.name &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), quantity.hashCode),
                        price.hashCode),
                    subtotal.hashCode),
                productId.hashCode),
            name.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderDetailModel')
          ..add('id', id)
          ..add('quantity', quantity)
          ..add('price', price)
          ..add('subtotal', subtotal)
          ..add('productId', productId)
          ..add('name', name)
          ..add('image', image))
        .toString();
  }
}

class OrderDetailModelBuilder
    implements Builder<OrderDetailModel, OrderDetailModelBuilder> {
  _$OrderDetailModel _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  int _quantity;
  int get quantity => _$this._quantity;
  set quantity(int quantity) => _$this._quantity = quantity;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  double _subtotal;
  double get subtotal => _$this._subtotal;
  set subtotal(double subtotal) => _$this._subtotal = subtotal;

  int _productId;
  int get productId => _$this._productId;
  set productId(int productId) => _$this._productId = productId;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  OrderDetailModelBuilder();

  OrderDetailModelBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _quantity = _$v.quantity;
      _price = _$v.price;
      _subtotal = _$v.subtotal;
      _productId = _$v.productId;
      _name = _$v.name;
      _image = _$v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderDetailModel other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrderDetailModel;
  }

  @override
  void update(void Function(OrderDetailModelBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderDetailModel build() {
    final _$result = _$v ??
        new _$OrderDetailModel._(
            id: id,
            quantity: quantity,
            price: price,
            subtotal: subtotal,
            productId: productId,
            name: name,
            image: image);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
