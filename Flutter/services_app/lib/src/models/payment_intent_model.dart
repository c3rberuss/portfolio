import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'payment_intent_model.g.dart';

abstract class PaymentIntentModel implements Built<PaymentIntentModel, PaymentIntentModelBuilder> {
  int get amount;

  String get currency;

  @BuiltValueField(wireName: 'payment_method')
  String get paymentMethod;

  PaymentIntentModel._();

  factory PaymentIntentModel([void Function(PaymentIntentModelBuilder) updates]) =
      _$PaymentIntentModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(PaymentIntentModel.serializer, this);
  }

  static PaymentIntentModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PaymentIntentModel.serializer, json);
  }

  static Serializer<PaymentIntentModel> get serializer => _$paymentIntentModelSerializer;
}
