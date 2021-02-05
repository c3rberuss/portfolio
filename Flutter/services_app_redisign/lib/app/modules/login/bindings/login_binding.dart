import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );

    Get.lazyPut<TextEditingController>(() => TextEditingController(), tag: "email");
    Get.lazyPut<TextEditingController>(() => TextEditingController(), tag: "password");
  }
}
