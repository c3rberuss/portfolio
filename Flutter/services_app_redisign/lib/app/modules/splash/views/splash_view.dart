import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/modules/splash/controllers/splash_controller.dart';
import 'package:services/app/routes/app_pages.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/widgets/app_logo.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      body: Builder(
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5)).then((value) {
            Get.offNamed(Routes.LOGIN);
          });

          return Stack(
            children: [
              Positioned.fill(
                child: Hero(
                  tag: "container",
                  child: Container(
                    color: Palette.primary,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogo(widthFactor: 0.35),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: LinearProgressIndicator(
                      backgroundColor: Palette.primary,
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.light),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
