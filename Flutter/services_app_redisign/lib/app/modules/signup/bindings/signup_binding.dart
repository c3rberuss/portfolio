import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/signup/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
      () => SignupController(),
    );

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "name",
    );

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "last_name",
    );

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "phone",
    );

    Get.lazyPut(() => FocusNode(), tag: "f_name");
    Get.lazyPut(() => FocusNode(), tag: "f_last_name");
    Get.lazyPut(() => FocusNode(), tag: "f_phone");

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "email",
    );

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "password",
    );

    Get.lazyPut<TextEditingController>(
      () => TextEditingController(),
      tag: "confirm",
    );

    Get.lazyPut(() => FocusNode(), tag: "f_email");
    Get.lazyPut(() => FocusNode(), tag: "f_password");
    Get.lazyPut(() => FocusNode(), tag: "f_confirm");
  }
}
