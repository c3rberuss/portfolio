import 'package:app/app/models/pagination_model.dart';
import 'package:app/core/domain/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Address {
  AddressModel({
    String address,
    String houseNumber,
    String reference,
    int department,
    String name,
    bool isDefault = false,
  }) : super(
          address: address,
          houseNumber: houseNumber,
          reference: reference,
          department: department,
          name: name,
          isDefault: isDefault,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}

@JsonSerializable(createToJson: false)
class AddressesResponsePaginatedModel extends AddressesResponsePaginated {
  AddressesResponsePaginatedModel(
      {int status,
      String timestamp,
      String message,
      List<AddressModel> data,
      PaginationModel pagination})
      : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );

  factory AddressesResponsePaginatedModel.fromJson(Map<String, dynamic> json) =>
      _$AddressesResponsePaginatedModelFromJson(json);
}
