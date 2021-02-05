// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoresResponseModel _$StoresResponseModelFromJson(Map<String, dynamic> json) {
  return StoresResponseModel(
    status: json['status'] as int,
    timestamp: json['timestamp'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : StoreModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) {
  return StoreModel(
    id: json['id'] as int,
    site: json['site'] == null
        ? null
        : SiteModel.fromJson(json['site'] as Map<String, dynamic>),
    name: json['name'] as String,
    estimatedDeliveryMinutes: json['estimatedDeliveryMinutes'] as int,
    maxToleranceMinutes: json['maxToleranceMinutes'] as int,
  );
}

SiteModel _$SiteModelFromJson(Map<String, dynamic> json) {
  return SiteModel(
    id: json['id'] as int,
    name: json['name'] as String,
    address: json['address'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    phone: json['phone'] as String,
    departmentId: json['departmentId'] as int,
    openAllDay: json['openAllDay'] as bool,
    openRightNow: json['openRightNow'] as bool,
    openTime24hrs: json['openTime24hrs'] as String,
    closeTime24hrs: json['closeTime24hrs'] as String,
    image: json['imageURL'] as String,
    distance: (json['distanceInKm'] as num)?.toDouble(),
    categories: (json['categories'] as List)?.map((e) => e as String)?.toList(),
  );
}
