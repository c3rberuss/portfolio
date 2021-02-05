import 'package:app/app/modules/landing/controllers/landing_controller.dart';
import 'package:app/core/interactors/auth_interactors.dart';
import 'package:get/get.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInWithFacebookInt>(
      () => SignInWithFacebookInt(
        Get.find(),
      ),
    );

    Get.lazyPut<SignInWithGoogleInt>(
      () => SignInWithGoogleInt(
        Get.find(),
      ),
    );

    Get.lazyPut<LandingController>(
      () => LandingController(),
    );
  }
}
