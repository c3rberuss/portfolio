import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:wallpapers/src/models/category_model.dart';
import 'package:wallpapers/src/utils/serializers.dart';

part 'categories_response.g.dart';

abstract class CategoriesResponse implements Built<CategoriesResponse, CategoriesResponseBuilder> {
  int get statusCode;
  BuiltList<CategoryModel> get data;

  CategoriesResponse._();
  factory CategoriesResponse([void Function(CategoriesResponseBuilder) updates]) = _$CategoriesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CategoriesResponse.serializer, this);
  }

  static CategoriesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CategoriesResponse.serializer, json);
  }

  static Serializer<CategoriesResponse> get serializer => _$categoriesResponseSerializer;
}
