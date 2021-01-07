import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:megalibreria/src/utils/serializers.dart';

part 'city_model.g.dart';

abstract class CityModel implements Built<CityModel, CityModelBuilder> {
  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'nombre')
  String get name;

  CityModel._();
  factory CityModel([void Function(CityModelBuilder) updates]) = _$CityModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(CityModel.serializer, this);
  }

  static CityModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(CityModel.serializer, json);
  }

  static Serializer<CityModel> get serializer => _$cityModelSerializer;
}