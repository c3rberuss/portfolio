import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart' as geo;
import 'package:location/location.dart';

import './bloc.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final _geo = new geo.GoogleMapsGeocoding(apiKey: MAPS_KEY);

  @override
  MapState get initialState => MapState.initial();

  MapBloc();

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is GetLocationEvent) {
      yield state.copyWith(loading: true);
      final location = await Location.instance.getLocation();
      final coords = LatLng(location.latitude, location.longitude);
      final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), "assets/icons/marker.png");

      yield* _mapLocation(coords, true, icon);

      yield state.copyWith(loading: false, coords: coords);
    } else if (event is ChangeCameraPositionEvent) {
      yield* _mapLocation(event.position);
      yield state.copyWith(coords: event.position);
    } else if (event is GetAddressEvent) {
      try {
        yield state.copyWith(locationChanged: true);
        final address = await _geo.searchByLocation(
          geo.Location(state.coords.latitude, state.coords.longitude),
        );

        bool correctArea = true;

        for (geo.AddressComponent c in address.results[0].addressComponents) {
          print("${c.longName} | ${c.shortName}");

          if (c.longName == "San Miguel") {
            correctArea = true;
            break;
          } else {
            correctArea = false;
          }
        }

        if (correctArea) {
          if (address.results.isNotEmpty) {
            var addressStr = address.results[0].formattedAddress.split(",");

            String addressFormatted = "";
            String fullAddress = "";

            for (geo.AddressComponent c in address.results[0].addressComponents) {
              print("${c.longName} | ${c.shortName}");

              fullAddress += c.longName + ", ";

              if (!c.longName.toLowerCase().contains("san miguel") &&
                  !c.longName.toLowerCase().contains("el salvador")) {
                addressFormatted += c.longName + ", ";
              }
            }

            if (addressFormatted.endsWith(", ")) {
              addressFormatted = addressFormatted.substring(0, addressFormatted.length - 2);
            }

            if (fullAddress.endsWith(", ")) {
              fullAddress = fullAddress.substring(0, fullAddress.length - 2);
            }

            yield state.copyWith(
              address: fullAddress, //address.results[0].formattedAddress,
              valid: true,
              addressShort: addressFormatted,
              locationChanged: false,
            );
          } else {
            yield state.copyWith(
              address: "Ubicación desconocida",
              addressShort: "Ubicación desconocida", //address.results[0].formattedAddress,
              locationChanged: false,
              valid: true,
            );
          }
        } else {
          yield state.copyWith(
            error: true,
            locationChanged: false,
            valid: false,
            message: "Debe seleccionar una ubicación en la zona metropolitana de San Miguel.",
          );

          yield state.copyWith(error: false);
        }
      } on SocketException catch (error) {
        print(error);
        yield state.copyWith(locationChanged: false, noInternet: true);
        yield state.copyWith(noInternet: false);
      }
    } else if (event is SaveAddressEvent) {
      final address = event.address.rebuild(
        (a) => a
          ..latitude = state.coords.latitude
          ..longitude = state.coords.longitude,
      );

      yield state.copyWith(success: true, finalAddress: address);

      yield state.copyWith(success: false, saving: false, error: false, noInternet: false);
    } else if (event is SetInitialAddress) {
      final coords = LatLng(event.latitude, event.longitude);

      final icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 2.5), "assets/icons/marker.png");

      yield* _mapLocation(coords, true, icon);
      yield state.copyWith(address: event.address, addressShort: event.address);

      print("initial");
    }
  }

  Stream<MapState> _mapLocation(LatLng coords,
      [bool changeCamPosition = false, BitmapDescriptor icon]) async* {
    CameraPosition camPosition;
    Set<Marker> markers = state.markers;
    BitmapDescriptor _icon = state.icon;

    if (changeCamPosition) {
      camPosition = CameraPosition(target: coords, zoom: 19.151926040649414);
      _icon = icon;
      markers = Set<Marker>();
    }

    final marker = Marker(
      markerId: MarkerId("my_location"),
      draggable: false,
      position: coords,
      icon: _icon,
    );

    markers.clear();
    markers.add(marker);

    if (changeCamPosition) {
      yield state.copyWith(
        cameraPosition: camPosition,
        markers: markers,
        coords: coords,
        loaded: true,
      );
    } else {
      yield state.copyWith(markers: markers, coords: coords);
    }
  }
}
