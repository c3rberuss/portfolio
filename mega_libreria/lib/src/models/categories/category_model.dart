import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'category_model.g.dart';

abstract class CategoryModel implements Built<CategoryModel, CategoryModelBuilder> {
//  {
//  "id_categoria": 1,
//  "nombre": "COMIDA RAPIDA",
//  "descripcion": "COMIDA",
//  "imagen": "http://esdely.apps-oss.com/"
//  }

  @BuiltValueField(wireName: 'id')
  int get id;

  @BuiltValueField(wireName: 'nombre')
  String get name;

  @BuiltValueField(wireName: 'imagen')
  String get image;

  CategoryModel._();

  factory CategoryModel([void Function(CategoryModelBuilder) updates]) = _$CategoryModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CategoryModel.serializer, this);
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CategoryModel.serializer, json);
  }

  static Serializer<CategoryModel> get serializer => _$categoryModelSerializer;
}
