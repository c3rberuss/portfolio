// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesResponseModel _$ServicesResponseModelFromJson(
    Map<String, dynamic> json) {
  return ServicesResponseModel(
    status: json['status'] as int,
    timestamp: json['timestamp'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ServiceModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return ServiceModel(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    image: json['iconURL'] as String,
  );
}
