import 'package:app/core/interactors/auth_interactors.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/signup/controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(
        signUpInt: Get.find(),
        verifyEmailInt: Get.find(),
      ),
    );

    Get.lazyPut<SignUpInt>(
      () => SignUpInt(Get.find()),
    );

    Get.lazyPut<VerifyEmailInt>(
      () => VerifyEmailInt(Get.find()),
    );
  }
}
