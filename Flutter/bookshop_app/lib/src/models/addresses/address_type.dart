import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'address_type.g.dart';

class AddressType extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 0)
  static const AddressType delivery = _$delivery;
  @BuiltValueEnumConst(wireNumber: 1)
  static const AddressType shipping = _$shipping;
  @BuiltValueEnumConst(fallback: true)
  static const AddressType unknown = _$unknown;

  const AddressType._(String name) : super(name);

  static BuiltSet<AddressType> get values => _$addressTypeValues;
  static AddressType valueOf(String name) => _$addressTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(AddressType.serializer, this);
  }

  static AddressType deserialize(String string) {
    return serializers.deserializeWith(AddressType.serializer, string);
  }

  static Serializer<AddressType> get serializer => _$addressTypeSerializer;
}
