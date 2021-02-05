import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _x1 = 83.92156907477228;
  final _y1 = 0.0;
  final _x2 = 224.0;
  final _y2 = 1.0;
  final RxInt currentPage = 0.obs;
  final PageController pageController = Get.find();

  double calcOpacity(double x) {
    return (((x - _x1) * (_y2 - _y1)) / (_x2 - _x1)) + _y1;
  }

  void goToPage(int page) {
    currentPage.value = page;
  }
}
