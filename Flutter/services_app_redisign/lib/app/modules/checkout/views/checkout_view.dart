import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:services/app/modules/checkout/views/location_picker_view.dart';
import 'package:services/app/modules/checkout/views/payment_method_view.dart';
import 'package:services/app/styles/palette.dart';

class CheckoutView extends GetView<CheckoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(LineIcons.arrow_left, color: Palette.primary),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Checkout your order',
          style: context.textTheme.headline6.copyWith(
            fontWeight: FontWeight.w400,
            color: Palette.primary,
          ),
        ),
      ),
      body: CoolStepper(
        contentPadding: EdgeInsets.all(0),
        config: CoolStepperConfig(
          headerColor: Palette.white,
          titleTextStyle: TextStyle(
            fontSize: 18,
            color: Palette.primary,
          ),
          subtitleTextStyle: TextStyle(
            fontWeight: FontWeight.w100,
            color: Palette.greyDark,
          ),
          progLabels: ["Pick", "Use"],
        ),
        onCompleted: () {},
        steps: [
          CoolStep(
            title: "Pick location",
            subtitle: "Select your car location",
            marginHeader: EdgeInsets.zero,
            content: SizedBox(
              height: Get.height * 0.67,
              child: LocationPickerView(),
            ),
            validation: () {
              return null;
            },
          ),
          CoolStep(
            title: "Payment method",
            subtitle: "Select your credit card",
            content: SizedBox(
              height: Get.height * 0.65,
              child: PaymentMethodView(),
            ),
            validation: () => null,
          )
        ],
      ),
    );
  }
}
