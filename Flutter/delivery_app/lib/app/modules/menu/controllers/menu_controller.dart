import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  final RxDouble bottom = 0.0.obs;
  final RxDouble top = (-100.0).obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();

    scrollController.addListener(toggleAppBar);
  }

  void toggleBottomPosition() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      bottom.value = -100;
    } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      bottom.value = -0.0;
    }
  }

  void toggleAppBar() {
    if (scrollController.position.pixels >= 184) {
      top.value = 0;
    } else if (scrollController.position.pixels <= 184) {
      top.value = -100;
    }
  }
}
