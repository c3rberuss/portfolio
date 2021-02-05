import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:wallpapers/src/utils/serializers.dart';

part 'category_model.g.dart';

abstract class CategoryModel implements Built<CategoryModel, CategoryModelBuilder> {
  String get name;
  String get url;
  String get partialUrl;

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