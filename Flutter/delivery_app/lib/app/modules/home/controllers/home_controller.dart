import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt _page = 0.obs;
  RxInt get page => _page;

  final PageController pageController = PageController();

  void toPage(int page) {
    pageController.jumpToPage(page);
    _page.value = page;
  }
}
