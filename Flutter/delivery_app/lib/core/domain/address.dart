import 'package:app/app/models/pagination_model.dart';
import 'package:app/core/domain/response.dart';

class Address {
  String address;
  String houseNumber;
  String reference;
  int department;
  String name;
  bool isDefault;

  Address({
    this.address,
    this.houseNumber,
    this.reference,
    this.department,
    this.name,
    this.isDefault,
  });
}

class AddressesResponsePaginated extends ResponsePagination<List<Address>> {
  AddressesResponsePaginated({
    int status,
    String timestamp,
    String message,
    List<Address> data,
    Pagination pagination,
  }) : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );
}
