import 'package:app/app/modules/splash/controllers/splash_controller.dart';
import 'package:app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        try {
          controller.remoteConfig.init().then((_) {
            Get.offAllNamed(Routes.LANDING);
          });
        } catch (e) {
          Get.offAllNamed(Routes.LOGIN);
        }

        return Scaffold(
          body: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width * 0.45,
                  height: Get.width * 0.45,
                  child: Placeholder(),
                ),
                SizedBox(height: 16),
                Text(
                  "LLEGO SV",
                  style: context.textTheme.headline3,
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: Get.width * 0.45,
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
