import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/checkout/controllers/payment_method_controller.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return CreditCardWidget(
          cvvCode: "123",
          cardHolderName: "Josue Amaya",
          showBackView: false,
          expiryDate: "12/22",
          cardNumber: "1234 1234 1234 1234",
          height: 200,
        );
      },
    );
  }
}
