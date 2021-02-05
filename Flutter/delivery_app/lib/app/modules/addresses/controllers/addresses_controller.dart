import 'package:get/get.dart';

class AddressesController extends GetxController {
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  RxBool editing = false.obs;
  RxDouble bottomFAB = (64.0).obs;
  RxDouble bottom = (-100.0).obs;

  void updateSelected(int index) {
    if (editing.value) {
      _indexSelected = index;
      update(["address"]);
    }
  }

  void useAsDefault() {
    editing.value = false;
    bottom.value = -100;
    bottomFAB.value = 32.0;
  }

  void selectAnimation(int index) {
    editing.value = true;
    bottom.value = 16.0;
    bottomFAB.value = 75.0;
    updateSelected(index);
  }
}
