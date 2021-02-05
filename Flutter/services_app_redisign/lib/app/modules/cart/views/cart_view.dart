import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/cart/controllers/cart_controller.dart';
import 'package:services/app/modules/cart/views/cart_item_widget.dart';
import 'package:services/app/modules/services/views/price_widget.dart';
import 'package:services/app/routes/app_pages.dart';
import 'package:services/app/styles/palette.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: Text(
          "My cart (10)",
          style: context.textTheme.headline6.copyWith(
            fontWeight: FontWeight.w400,
            color: Palette.primary,
          ),
        ),
        iconTheme: context.theme.iconTheme.copyWith(color: Palette.primary),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.all(16),
        itemBuilder: (BuildContext context, int index) {
          return CardItemWidget();
        },
      ),
      bottomNavigationBar: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(),
                  Expanded(child: PriceWidget(10.25)),
                  MaterialButton(
                    color: Palette.success,
                    splashColor: Palette.light.withOpacity(0.1),
                    textColor: Palette.light,
                    child: Text("Checkout"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.CHECKOUT);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
