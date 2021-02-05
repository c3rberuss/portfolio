import 'package:app/app/models/pagination_model.dart';
import 'package:app/core/domain/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable(nullable: true, createToJson: false)
class StoresResponseModel extends StoresResponse {
  StoresResponseModel({
    int status,
    String timestamp,
    String message,
    List<StoreModel> data,
    PaginationModel pagination,
  }) : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );

  factory StoresResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoresResponseModelFromJson(json);
}

@JsonSerializable(nullable: true, createToJson: false)
class StoreModel extends Store {
  StoreModel({
    int id,
    SiteModel site,
    String name,
    int estimatedDeliveryMinutes,
    int maxToleranceMinutes,
  }) : super(
          id: id,
          site: site,
          name: name,
          estimatedDeliveryMinutes: estimatedDeliveryMinutes,
          maxToleranceMinutes: maxToleranceMinutes,
        );

  factory StoreModel.fromJson(Map<String, dynamic> json) => _$StoreModelFromJson(json);
}

@JsonSerializable(nullable: true, createToJson: false)
class SiteModel extends Site {
  SiteModel({
    int id,
    String name,
    String address,
    double latitude,
    double longitude,
    String phone,
    int departmentId,
    bool openAllDay,
    bool openRightNow,
    String openTime24hrs,
    String closeTime24hrs,
    this.image,
    this.distance,
    List<String> categories,
  }) : super(
          id: id,
          name: name,
          address: address,
          latitude: latitude,
          longitude: longitude,
          phone: phone,
          departmentId: departmentId,
          openAllDay: openAllDay,
          openRightNow: openRightNow,
          openTime24hrs: openTime24hrs,
          closeTime24hrs: closeTime24hrs,
          image: image,
          distance: distance,
          categories: categories,
        );

  @override
  @JsonKey(name: "imageURL")
  String image;

  @override
  @JsonKey(name: "distanceInKm")
  double distance;

  factory SiteModel.fromJson(Map<String, dynamic> json) => _$SiteModelFromJson(json);
}
