import 'package:app/core/domain/address_geo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_address_model.g.dart';

@JsonSerializable(createToJson: false, explicitToJson: true)
class GeoAddressModel extends AddressGeo {
  GeoAddressModel(this.street, this.city, this.country) : super(street, city, country);

  @JsonKey(name: "street", nullable: false)
  String street;

  @JsonKey(name: "adminArea5", nullable: false)
  String city;

  @JsonKey(name: "adminArea4", defaultValue: "El Salvador")
  String country = "El Salvador";

  factory GeoAddressModel.fromJson(Map<String, dynamic> json) => _$GeoAddressModelFromJson(json);
}
