import 'package:app/core/interactors/auth_interactors.dart';
import 'package:app/core/interactors/user_interactors.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
        getLocalUserInfo: Get.find(),
        getUserInfo: Get.find(),
        linkFacebookAccount: Get.find(),
        linkGoogleAccount: Get.find(),
        verifyEmail: Get.find(),
        signOut: Get.find(),
      ),
    );

    Get.lazyPut<GetUserInfoInt>(
      () => GetUserInfoInt(Get.find()),
    );

    Get.lazyPut<LinkFacebookAccountInt>(
      () => LinkFacebookAccountInt(Get.find()),
    );

    Get.lazyPut<LinkGoogleAccountInt>(
      () => LinkGoogleAccountInt(Get.find()),
    );

    Get.lazyPut<VerifyEmailInt>(
      () => VerifyEmailInt(Get.find()),
    );

    Get.lazyPut<GetLocalUserInfoInt>(
      () => GetLocalUserInfoInt(Get.find()),
    );

    Get.lazyPut<SignOutInt>(
      () => SignOutInt(Get.find()),
    );
  }
}
