import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'category_model.dart';

part 'categories_pagination.g.dart';

abstract class CategoriesPagination
    implements Built<CategoriesPagination, CategoriesPaginationBuilder> {
  @BuiltValueField(wireName: 'pages')
  int get totalPages;
  @BuiltValueField(wireName: 'actual')
  int get page;
  @nullable
  BuiltList<CategoryModel> get data;

  CategoriesPagination._();
  factory CategoriesPagination([void Function(CategoriesPaginationBuilder) updates]) =
      _$CategoriesPagination;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CategoriesPagination.serializer, this);
  }

  static CategoriesPagination fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CategoriesPagination.serializer, json);
  }

  static Serializer<CategoriesPagination> get serializer => _$categoriesPaginationSerializer;
}
