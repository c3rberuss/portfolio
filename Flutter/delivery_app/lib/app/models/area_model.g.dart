// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreasResponseModel _$AreasResponseModelFromJson(Map<String, dynamic> json) {
  return AreasResponseModel(
    status: json['status'] as int,
    timestamp: json['timestamp'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AreaModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) {
  return AreaModel(
    json['id'] as int,
    json['name'] as String,
    (json['coordinates'] as List)
        ?.map((e) => e == null
            ? null
            : CoordinateModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

CoordinateModel _$CoordinateModelFromJson(Map<String, dynamic> json) {
  return CoordinateModel(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordinateModelToJson(CoordinateModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
