import 'package:app/core/interactors/api_interactors.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/stores/controllers/stores_controller.dart';

class StoresBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoresController>(
      () => StoresController(
        fetchStores: Get.find(),
      ),
    );

    Get.lazyPut<FetchStoresInt>(
      () => FetchStoresInt(Get.find()),
    );
  }
}
