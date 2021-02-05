import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/service_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'services_response.g.dart';

abstract class ServicesResponse implements Built<ServicesResponse, ServicesResponseBuilder> {
  int get code;

  String get message;

  @nullable
  BuiltList<ServiceModel> get data;

  ServicesResponse._();

  factory ServicesResponse([void Function(ServicesResponseBuilder) updates]) = _$ServicesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ServicesResponse.serializer, this);
  }

  static ServicesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ServicesResponse.serializer, json);
  }

  static Serializer<ServicesResponse> get serializer => _$servicesResponseSerializer;
}
