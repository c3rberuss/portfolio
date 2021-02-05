import 'package:app/core/domain/address.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  Address _address = Address();
  Address get address => _address;

  void initialize(String address) {
    this._address.address = address;
  }
}
