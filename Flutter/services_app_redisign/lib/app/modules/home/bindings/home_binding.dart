import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<PageController>(() => PageController());
  }
}
