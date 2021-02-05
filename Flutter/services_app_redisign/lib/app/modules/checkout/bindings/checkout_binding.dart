import 'package:get/get.dart';
import 'package:services/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:services/app/modules/checkout/controllers/location_picker_controller.dart';
import 'package:services/app/modules/checkout/controllers/payment_method_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );

    Get.lazyPut<LocationPickerController>(
      () => LocationPickerController(),
      fenix: true,
    );

    Get.lazyPut<PaymentMethodController>(
      () => PaymentMethodController(),
      fenix: true,
    );
  }
}
