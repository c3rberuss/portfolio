import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

import 'fare_model.dart';

part 'fare_response.g.dart';

abstract class FareResponse implements Built<FareResponse, FareResponseBuilder> {
  int get code;
  String get message;
  @nullable
  FareModel get data;

  FareResponse._();
  factory FareResponse([void Function(FareResponseBuilder) updates]) = _$FareResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(FareResponse.serializer, this);
  }

  static FareResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(FareResponse.serializer, json);
  }

  static Serializer<FareResponse> get serializer => _$fareResponseSerializer;
}