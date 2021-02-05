import 'package:bookshop/src/models/products/product_type.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_model.g.dart';

abstract class ProductModel implements Built<ProductModel, ProductModelBuilder> {
/*  "id_producto": 9,
  "nombre": "PAPAS FRITAS",
  "descripcion": "CON KETCHUP",
  "precio": 2.5,
  "foto": "http://esdely.apps-oss.com/",
  "id_empresa": 1,
  "disponible": 0,
  "con_stock": 0,
  "stock": 0,
  "activo": 1*/

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'marca')
  String get brand;

  @BuiltValueField(wireName: 'nombre')
  String get name;

  @BuiltValueField(wireName: 'descripcion')
  String get description;

  @BuiltValueField(wireName: 'imagen')
  String get image;

  @BuiltValueField(wireName: 'thumb1')
  String get thumb;

  @BuiltValueField(wireName: 'precio')
  double get price;

  @nullable
  int get stock;

  @nullable
  @BuiltValueField(wireName: 'tipo')
  ProductType get type;

  ProductModel._();

  factory ProductModel([void Function(ProductModelBuilder) updates]) = _$ProductModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ProductModel.serializer, this);
  }

  static ProductModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ProductModel.serializer, json);
  }

  static Serializer<ProductModel> get serializer => _$productModelSerializer;
}
