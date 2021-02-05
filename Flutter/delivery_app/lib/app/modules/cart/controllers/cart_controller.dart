import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxDouble bottomDetail = (-315.0).obs;

  void toggleAnimation() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      bottomDetail.value = -315;
    } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      bottomDetail.value = 0;
    }
  }
}
