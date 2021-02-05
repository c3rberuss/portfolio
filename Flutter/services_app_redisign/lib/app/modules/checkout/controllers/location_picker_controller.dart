import 'package:get/get.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class LocationPickerController extends GetxController {
  MapboxMapController _controller;
  CameraPosition _initialCamera = CameraPosition(target: LatLng(36.764604, -119.736300), zoom: 16);
  LatLng currentLocation;

  CameraPosition get camera => _initialCamera;

  void setMapController(MapboxMapController controller) {
    _controller = controller;
  }

  @override
  void onReady() {
    super.onReady();
    //changeToCurrentLocation();
  }

  // Future<LatLng> getCurrentLocation() async {
  //   // final location = await _location.getLocation();
  //   // return LatLng(location.latitude, location.longitude);
  // }

  // void changeToCurrentLocation() {
  //   getCurrentLocation().then(
  //         (location) {
  //       _controller.animateCamera(
  //         CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 16)),
  //       );
  //     },
  //   );
  // }

  Future<void> setCurrentLocation(LatLng newLocation) async {
    currentLocation = newLocation;
  }
}
