import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/utils/mixins.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceView extends StatelessWidget with Maintenance {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        margin: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * 0.4,
              height: Get.width * 0.4,
              child: FlareActor(
                "assets/animations/mantenimiento.flr",
                animation: "spin",
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(height: 32),
            Text(
              "LLeGo en mantenimiento",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 32),
            Text(
              "Estamos trabajando para brindarte el servicio de calidad que mereces. En unos minutos estaremos de regreso para que puedas pedir lo que nececites con LleGo.",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            CustomFillButton(
              text: "Recargar",
              buttonType: CustomButtonType.dark,
              onPressed: () async {
                final isInMaintenance = await inMaintenance();
                if (!isInMaintenance) {
                  Get.offAllNamed(Routes.HOME);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
