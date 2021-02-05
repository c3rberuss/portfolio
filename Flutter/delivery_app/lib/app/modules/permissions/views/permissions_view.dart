import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/permissions/controllers/permissions_controller.dart';
import 'package:line_icons/line_icons.dart';

class PermissionsView extends GetView<PermissionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            LineIcons.times,
            color: Palette.dark,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'LLeGo SV',
          style: TextStyle(
            color: Palette.dark,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        backgroundColor: Palette.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Permisos de la aplicación",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 45),
            const Text(
              "Delivery App tiene como prioridad generarte la mejor experiencia al realizar tus pedidos, para ello necesitamos que brindes a la aplicación algunos permisos que nos permitirán operar de la mejor manera:",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 40, bottom: 64),
              decoration: Styles.boxDecoration(),
              child: Row(
                children: [
                  const Icon(
                    LineIcons.map_pin,
                    size: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ubicación: ",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "Usamos el servicio de ubicación para ayudarte a ubicar tu posición y así saber con precisión donde irá nuestro driver.",
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            CustomFillButton(
              text: "Conceder permisos",
              buttonType: CustomButtonType.dark,
              fullWidth: true,
              maxWidth: 300,
              minWidth: 300,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
