import 'package:get/get.dart';

import 'package:app/app/modules/permissions/controllers/permissions_controller.dart';

class PermissionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermissionsController>(
      () => PermissionsController(),
    );
  }
}
