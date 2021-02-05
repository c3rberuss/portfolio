import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'city_model.dart';

part 'cities_response.g.dart';

abstract class CitiesResponse implements Built<CitiesResponse, CitiesResponseBuilder> {
  int get code;
  String get message;
  @nullable
  BuiltList<CityModel> get data;

  CitiesResponse._();
  factory CitiesResponse([void Function(CitiesResponseBuilder) updates]) = _$CitiesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CitiesResponse.serializer, this);
  }

  static CitiesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CitiesResponse.serializer, json);
  }

  static Serializer<CitiesResponse> get serializer => _$citiesResponseSerializer;
}
