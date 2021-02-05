import 'package:app/app/framework/api_data_source_impl.dart';
import 'package:app/app/modules/home/controllers/services_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/core/data/api_repository.dart';
import 'package:app/core/interactors/api_interactors.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiRepository>(
      () => ApiRepository(
        //ApiDataSourceTestImpl(),
        ApiDataSourceImpl(
          Get.find(),
        ),
      ),
      fenix: true,
    );

    Get.put<HomeController>(HomeController());

    Get.put<ServicesController>(
      ServicesController(
        FetchServicesInt(Get.find()),
      ),
    );

    //TODO: inject interactors for the home screen
  }
}
