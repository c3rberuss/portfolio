import 'package:app/core/domain/response.dart';

class StoresResponse extends ResponsePagination<List<Store>> {
  StoresResponse(
      {int status, String timestamp, String message, List<Store> data, Pagination pagination})
      : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );
}

class Store {
  int id;
  Site site;
  String name;
  int estimatedDeliveryMinutes;
  int maxToleranceMinutes;

  Store({this.id, this.site, this.name, this.estimatedDeliveryMinutes, this.maxToleranceMinutes});
}

class Site {
  int id;
  String name;
  String address;
  double latitude;
  double longitude;
  String phone;
  int departmentId;
  bool openAllDay;
  bool openRightNow;
  String openTime24hrs;
  String closeTime24hrs;
  String image;
  double distance;
  List<String> categories;

  Site({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.departmentId,
    this.openAllDay,
    this.openRightNow,
    this.openTime24hrs,
    this.closeTime24hrs,
    this.image,
    this.categories,
    this.distance,
  });
}
