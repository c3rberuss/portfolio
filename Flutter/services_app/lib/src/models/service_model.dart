import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'service_model.g.dart';

abstract class ServiceModel implements Built<ServiceModel, ServiceModelBuilder> {
/*  {
  "id_service": 2,
  "title": "Wishing",
  "description": "Tires washing",
  "image": "http://tires.solucionesideales.com/images/car.png",
  "price": 10,
  "workforce": 5
  },*/

  @BuiltValueField(wireName: 'id_service')
  int get serviceId;

  String get title;

  String get description;

  String get image;

  double get price;

  double get workforce;

  ServiceModel._();

  factory ServiceModel([void Function(ServiceModelBuilder) updates]) = _$ServiceModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ServiceModel.serializer, this);
  }

  static ServiceModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ServiceModel.serializer, json);
  }

  static Serializer<ServiceModel> get serializer => _$serviceModelSerializer;
}
