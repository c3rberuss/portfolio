import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:services/app/modules/checkout/controllers/location_picker_controller.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/utils/constants.dart';

class LocationPickerView extends GetView<LocationPickerController> {
  final iconHeight = Get.height * 0.1;
  final iconWidth = Get.width * 0.1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: <Widget>[
            GetBuilder<LocationPickerController>(
              id: "map",
              builder: (_) {
                return MapboxMap(
                  accessToken: MAPBOX_TOKEN,
                  myLocationEnabled: true,
                  styleString: "mapbox://styles/c3rberuss/ckh8q7ubz1ihw19n6h2c9e4aq",
                  initialCameraPosition: _.camera,
                  onMapCreated: _.setMapController,
                  onCameraIdle: () {},
                  // onCameraMove: (cameraPosition) {
                  //   _.setCurrentLocation(cameraPosition.target);
                  // },
                );
              },
            ),
            // CustomPaint(
            //   painter: PainterCenter(),
            //   child: SizedBox(
            //     width: constraints.biggest.width,
            //     height: constraints.biggest.height,
            //   ),
            // ),
            Positioned(
              child: Image.asset(
                "assets/icons/pin.png",
                width: iconWidth,
                height: iconHeight,
              ),
              left: constraints.biggest.width * 0.5 - (iconWidth / 2),
              right: constraints.biggest.width * 0.5 - (iconWidth / 2),
              bottom: (constraints.biggest.height * 0.485),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                child: Icon(Icons.my_location, color: Palette.light),
                backgroundColor: Palette.primary,
                elevation: 5,
                highlightElevation: 7,
                onPressed: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
