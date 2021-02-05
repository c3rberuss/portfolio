// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    address: json['address'] as String,
    houseNumber: json['houseNumber'] as String,
    reference: json['reference'] as String,
    department: json['department'] as int,
    name: json['name'] as String,
    isDefault: json['isDefault'] as bool,
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'houseNumber': instance.houseNumber,
      'reference': instance.reference,
      'department': instance.department,
      'name': instance.name,
      'isDefault': instance.isDefault,
    };

AddressesResponsePaginatedModel _$AddressesResponsePaginatedModelFromJson(
    Map<String, dynamic> json) {
  return AddressesResponsePaginatedModel(
    status: json['status'] as int,
    timestamp: json['timestamp'] as String,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AddressModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pagination: json['pagination'] == null
        ? null
        : PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
  );
}
