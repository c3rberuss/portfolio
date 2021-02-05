import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'product_type.g.dart';

class ProductType extends EnumClass {
  @BuiltValueEnumConst(wireName: 'VIRTUAL')
  static const ProductType virtual = _$virtual;

  @BuiltValueEnumConst(fallback: true)
  static const ProductType physical = _$physical;

  const ProductType._(String name) : super(name);

  static BuiltSet<ProductType> get values => _$productTypeValues;
  static ProductType valueOf(String name) => _$productTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(ProductType.serializer, this);
  }

  static ProductType deserialize(String string) {
    return serializers.deserializeWith(ProductType.serializer, string);
  }

  static Serializer<ProductType> get serializer => _$productTypeSerializer;
}
