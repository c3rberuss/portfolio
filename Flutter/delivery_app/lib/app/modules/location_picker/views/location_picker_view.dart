import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:app/app/widgets/custom_dialog.dart';
import 'package:app/core/domain/address.dart';
import 'package:app/core/domain/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:app/app/modules/location_picker/controllers/location_picker_controller.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerView extends GetView<LocationPickerController> {
  final iconHeight = Get.height * 0.1;
  final iconWidth = Get.width * 0.1;

  @override
  Widget build(BuildContext context) {
    final Future<Address> Function(String) onPickLocation = Get.arguments;

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                GetBuilder<LocationPickerController>(
                  id: "map",
                  builder: (_) {
                    if (controller.status is Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: controller.camera,
                      onMapCreated: controller.setMapController,
                      polygons: controller.polygons,
                      onCameraIdle: () {
                        controller.getAddress();
                      },
                      onCameraMove: (cameraPosition) {
                        controller.setCurrentLocation(cameraPosition.target);
                      },
                    );
                  },
                ),
                /*CustomPaint(
                    painter: PainterCenter(),
                    child: SizedBox(
                      width: constraints.biggest.width,
                      height: constraints.biggest.height,
                    ),
                  ),*/
                GetBuilder<LocationPickerController>(
                  id: "status",
                  builder: (_) {
                    if (controller.status is Loading) {
                      return SizedBox.shrink();
                    }

                    return Positioned(
                      child: SvgPicture.asset(
                        "assets/icons/pin.svg",
                        color: Palette.dark,
                        width: iconWidth,
                        height: iconHeight,
                      ),
                      left: constraints.biggest.width * 0.5 - (iconWidth / 2),
                      right: constraints.biggest.width * 0.5 - (iconWidth / 2),
                      bottom: (constraints.biggest.height * 0.475),
                    );
                  },
                ),
                Positioned(
                  top: Get.height * 0.01,
                  left: Get.width * 0.01,
                  right: Get.width * 0.01,
                  child: SafeArea(
                    child: Card(
                      shape: Styles.shapeRounded(),
                      elevation: 4,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 15,
                                color: Palette.dark.withOpacity(0.5),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            Expanded(
                              child: GetBuilder<LocationPickerController>(
                                id: "address",
                                builder: (_) {
                                  if (_.addressState is Loading) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16, left: 16),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Palette.dark.withOpacity(0.3),
                                          valueColor: AlwaysStoppedAnimation(Palette.dark),
                                        ),
                                      ),
                                    );
                                  }

                                  return Text(
                                    _.address,
                                    style: TextStyle(color: Palette.dark.withOpacity(0.7)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: GetBuilder<LocationPickerController>(
          id: "status",
          builder: (_) {
            if (controller.status is Loading) {
              return SizedBox.shrink();
            }

            return FloatingActionButton(
              backgroundColor: Palette.dark,
              child: Icon(
                Icons.my_location,
                color: Palette.white,
              ),
              onPressed: controller.changeToCurrentLocation,
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Palette.white,
            boxShadow: [
              BoxShadow(blurRadius: 10, spreadRadius: -5),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AutoSizeText(
                "Ayúdanos a encontrar tu dirección",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Fija el pin en la dirección que desees.",
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              ),
              SizedBox(height: 8),
              GetBuilder<LocationPickerController>(
                id: "status",
                builder: (_) {
                  return CustomFillButton(
                    text: "Fijar dirección",
                    buttonType: CustomButtonType.dark,
                    fullWidth: true,
                    isEnabled: !(controller.status is Loading),
                    maxWidth: 500,
                    minWidth: 500,
                    onPressed: () {
                      _checkIfLocationIsValid(context, onPickLocation);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkIfLocationIsValid(
      BuildContext context, Future<Address> Function(String) onPickLocation) async {
    final isValid = controller.validLocation();

    if (!isValid) {
      showDialog(
        context: context,
        child: CustomDialog(
          title: "¡Qué pena nos da!",
          content: "Aún no brindamos servicio en esa zona.",
          dialogType: DialogType.Info,
        ),
      );
    } else {
      if (onPickLocation != null) {
        final result = await onPickLocation(controller.address);
        if (result != null) {
          Get.back<Address>(result: result);
        }
      }
    }
  }
}
