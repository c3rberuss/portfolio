import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'payment_type.g.dart';

class PaymentType extends EnumClass {
  static const PaymentType creditCard = _$creditCard;
  static const PaymentType cash = _$cash;

  const PaymentType._(String name) : super(name);

  static BuiltSet<PaymentType> get values => _$paymentTypeValues;
  static PaymentType valueOf(String name) => _$paymentTypeValueOf(name);

  String serialize() {
    return serializers.serializeWith(PaymentType.serializer, this);
  }

  static PaymentType deserialize(String string) {
    return serializers.deserializeWith(PaymentType.serializer, string);
  }

  static Serializer<PaymentType> get serializer => _$paymentTypeSerializer;
}