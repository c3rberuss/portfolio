import 'package:app/app/models/geo_address_model.dart';
import 'package:app/app/styles/palette.dart';
import 'package:app/core/domain/address.dart';
import 'package:app/core/domain/address_geo.dart';
import 'package:app/core/domain/area.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/interactors/api_interactors.dart';
import 'package:app/core/interactors/geocoding_interactors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as poly;

class LocationPickerController extends GetxController {
  GetGeoAddressInt _interactor;
  FetchServiceAreaInt _fetchServiceArea;
  final Location _location = Location();
  Resource _status = Loading();

  Resource get status => _status;
  Map<int, List<poly.LatLng>> _areas = {};

  String address = "Cargando...";

  GoogleMapController _controller;
  CameraPosition _initialCamera = CameraPosition(target: LatLng(13.710035, -88.762736), zoom: 16);
  LatLng currentLocation;

  Resource<AddressGeo> addressState = Loading();
  Set<Polygon> polygons = Set();
  CameraPosition get camera => _initialCamera;

  LocationPickerController({
    @required GetGeoAddressInt getGeoAddressInt,
    @required FetchServiceAreaInt fetchServiceAreaInt,
  }) {
    this._interactor = getGeoAddressInt;
    this._fetchServiceArea = fetchServiceAreaInt;
  }

  void setMapController(GoogleMapController controller) {
    _controller = controller;
    changeToCurrentLocation();
  }

  @override
  void onReady() {
    super.onReady();
    _fetchServiceArea(1).then(_manageAreas);

    SystemChannels.lifecycle.setMessageHandler((message) {
      print("LIFE CYCLE : $message");

      if (message == "AppLifecycleState.resumed") {
        update(["map"]);
      }

      return Future.value(message);
    });
  }

  void _manageAreas(Resource<List<Area>> areas) {
    if (areas is Success<List<Area>>) {
      _status = Success();

      areas.data.forEach((area) {
        List<poly.LatLng> _area =
            area.coordinates.map((coord) => poly.LatLng(coord.latitude, coord.longitude)).toList();

        _area = poly.PolygonUtil.simplify(_area, 10);
        _areas[area.id] = _area;

        final polygon = _area.map((e) => LatLng(e.latitude, e.longitude)).toList();
        polygons.add(_createPolygon(area.name, polygon));
      });

      update(['map', "status", "address"]);
      changeToCurrentLocation();
    }
  }

  Future<LatLng> getCurrentLocation() async {
    final location = await _location.getLocation();
    return LatLng(location.latitude, location.longitude);
  }

  void changeToCurrentLocation() {
    getCurrentLocation().then(
      (location) {
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(target: location, zoom: 16)),
          );
        }
      },
    );
  }

  Future<void> setCurrentLocation(LatLng newLocation) async {
    currentLocation = newLocation;
  }

  Future<void> getAddress() async {
    if (currentLocation != null) {
      this.addressState = Loading();
      update(['address']);

      this.addressState = await _interactor.call(
        currentLocation.latitude,
        currentLocation.longitude,
      );

      if (this.addressState is Success<GeoAddressModel>) {
        final data = (this.addressState as Success<GeoAddressModel>).data;
        if (data.street.isNotEmpty) {
          address = data.street + ", " + data.city;
          if (data.country.isNotEmpty) address += ", " + data.country;
        } else {
          address = "¡No se ha encontrado una dirección para esa locatión!";
        }
      } else {
        address = "¡No se ha encontrado una dirección para esa locatión!";
      }

      update(['address']);
    }
  }

  Polygon _createPolygon(String name, List<LatLng> points) {
    return Polygon(
      polygonId: PolygonId(name),
      points: points,
      strokeColor: Palette.primary,
      fillColor: Palette.dark.withOpacity(0.1),
      strokeWidth: 1,
    );
  }

  //check if current location is in service area
  bool validLocation() {
    for (List<poly.LatLng> _polygon in _areas.values) {
      final valid = poly.PolygonUtil.containsLocation(
        poly.LatLng(currentLocation.latitude, currentLocation.longitude),
        _polygon,
        false,
      );

      if (valid) return true;
    }

    return false;
  }
}
