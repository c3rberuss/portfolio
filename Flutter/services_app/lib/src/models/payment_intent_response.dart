import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'payment_intent_response.g.dart';

abstract class PaymentIntentResponse
    implements Built<PaymentIntentResponse, PaymentIntentResponseBuilder> {
  int get amount;

  String get id;

  @BuiltValueField(wireName: 'client_secret')
  String get clientSecret;

  String get currency;

  int get created;

  PaymentIntentResponse._();

  factory PaymentIntentResponse([void Function(PaymentIntentResponseBuilder) updates]) =
      _$PaymentIntentResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(PaymentIntentResponse.serializer, this);
  }

  static PaymentIntentResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PaymentIntentResponse.serializer, json);
  }

  static Serializer<PaymentIntentResponse> get serializer => _$paymentIntentResponseSerializer;
}
