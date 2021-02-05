import 'package:get/get.dart';

import 'package:app/app/modules/addresses/controllers/addresses_controller.dart';

class AddressesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressesController>(
      () => AddressesController(),
    );
  }
}
