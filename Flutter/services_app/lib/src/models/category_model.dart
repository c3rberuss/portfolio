import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'category_model.g.dart';

abstract class CategoryModel implements Built<CategoryModel, CategoryModelBuilder> {
  @BuiltValueField(wireName: 'id_catalog')
  int get idCatalog;

  String get title;

  String get image;

  CategoryModel._();

  factory CategoryModel([void Function(CategoryModelBuilder) updates]) = _$CategoryModel;

  String serialize() {
    return serializers.serializeWith(CategoryModel.serializer, this);
  }

  static CategoryModel deserialize(String string) {
    return serializers.deserializeWith(CategoryModel.serializer, string);
  }

  static Serializer<CategoryModel> get serializer => _$categoryModelSerializer;
}
