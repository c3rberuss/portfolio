import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/result/controllers/result_controller.dart';
import 'package:line_icons/line_icons.dart';

class ResultView extends GetView<ResultController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dark,
      body: Container(
        margin: EdgeInsets.all(32),
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              LineIcons.unlink,
              size: 128,
              color: Palette.white,
            ),
            SizedBox(height: 32),
            Text(
              "¡Un nuevo pedido",
              style: TextStyle(
                fontSize: 20,
                color: Palette.white,
              ),
            ),
            Text(
              "Delivery!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Palette.white,
              ),
            ),
            SizedBox(height: 45),
            Text(
              "Estamos procesando tu pedido y pronto lo estarás recibiendo",
              style: TextStyle(
                fontSize: 18,
                color: Palette.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            CustomFillButton(
              text: "Ver mi pedido",
              buttonType: CustomButtonType.light,
              fullWidth: true,
              maxWidth: 300,
              minWidth: 300,
              onPressed: () {
                Get.offNamed(Routes.HOME);
              },
            )
          ],
        ),
      ),
    );
  }
}
