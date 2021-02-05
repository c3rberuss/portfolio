import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'address_status.g.dart';

class AddressStatus extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 1)
  static const AddressStatus isPredefined = _$isPredefined;
  @BuiltValueEnumConst(wireNumber: 0, fallback: true)
  static const AddressStatus isNotPredefined = _$isNotPredefined;

  const AddressStatus._(String name) : super(name);

  static BuiltSet<AddressStatus> get values => _$addressStatusValues;
  static AddressStatus valueOf(String name) => _$addressStatusValueOf(name);

  String serialize() {
    return serializers.serializeWith(AddressStatus.serializer, this);
  }

  static AddressStatus deserialize(String string) {
    return serializers.deserializeWith(AddressStatus.serializer, string);
  }

  static Serializer<AddressStatus> get serializer => _$addressStatusSerializer;
}
