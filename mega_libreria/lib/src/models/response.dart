import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'response.g.dart';

abstract class Response implements Built<Response, ResponseBuilder> {
  int get code;
  String get message;

  Response._();
  factory Response([void Function(ResponseBuilder) updates]) = _$Response;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(Response.serializer, this);
  }

  static Response fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Response.serializer, json);
  }

  static Serializer<Response> get serializer => _$responseSerializer;
}