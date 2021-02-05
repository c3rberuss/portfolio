import 'package:bookshop/src/models/products/product_model.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'products_pagination.g.dart';

abstract class ProductsPagination implements Built<ProductsPagination, ProductsPaginationBuilder> {
  @BuiltValueField(wireName: 'pages')
  int get totalPages;
  @BuiltValueField(wireName: 'actual')
  int get page;
  @nullable
  BuiltList<ProductModel> get data;

  ProductsPagination._();
  factory ProductsPagination([void Function(ProductsPaginationBuilder) updates]) =
      _$ProductsPagination;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ProductsPagination.serializer, this);
  }

  static ProductsPagination fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ProductsPagination.serializer, json);
  }

  static Serializer<ProductsPagination> get serializer => _$productsPaginationSerializer;
}
