import 'package:bookshop/src/models/products/products_pagination.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'products_response.g.dart';

abstract class ProductsResponse implements Built<ProductsResponse, ProductsResponseBuilder> {
  int get code;
  String get message;
  @nullable
  @BuiltValueField(wireName: 'data')
  ProductsPagination get body;

  ProductsResponse._();
  factory ProductsResponse([void Function(ProductsResponseBuilder) updates]) = _$ProductsResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ProductsResponse.serializer, this);
  }

  static ProductsResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ProductsResponse.serializer, json);
  }

  static Serializer<ProductsResponse> get serializer => _$productsResponseSerializer;
}
