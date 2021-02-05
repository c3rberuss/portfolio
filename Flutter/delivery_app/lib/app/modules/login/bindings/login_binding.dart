import 'package:app/core/interactors/auth_interactors.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        signInWithEmailInt: Get.find(),
        signInWithFacebook: Get.find(),
        signInWithGoogle: Get.find(),
      ),
    );

    Get.lazyPut<SignInWithGoogleInt>(
      () => SignInWithGoogleInt(Get.find()),
    );

    Get.lazyPut<SignInWithFacebookInt>(
      () => SignInWithFacebookInt(Get.find()),
    );
    Get.lazyPut<SignInWithEmailInt>(
      () => SignInWithEmailInt(Get.find()),
    );
  }
}
