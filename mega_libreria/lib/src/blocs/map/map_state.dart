import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';

class MapState extends Equatable {
  final Set<Marker> markers;
  final LatLng coords;
  final CameraPosition cameraPosition;
  final bool loading;
  final bool locationChanged;
  final String address;
  final bool loaded;
  final BitmapDescriptor icon;
  final String addressShort;
  final bool savingAddress;
  final bool success;
  final bool error;
  final bool noInternet;
  final AddressModel finalAddress;
  final String message;
  final bool validLocation;

  MapState({
    @required this.markers,
    @required this.coords,
    @required this.loading,
    @required this.cameraPosition,
    @required this.locationChanged,
    @required this.address,
    @required this.loaded,
    @required this.icon,
    @required this.addressShort,
    @required this.savingAddress,
    @required this.success,
    @required this.error,
    @required this.noInternet,
    @required this.finalAddress,
    @required this.message,
    @required this.validLocation,
  });

  factory MapState.initial() {
    return MapState(
      markers: Set<Marker>(),
      coords: LatLng(13.486029744040653, -88.18583120967105),
      loading: false,
      cameraPosition: CameraPosition(
        target: LatLng(13.486029744040653, -88.18583120967105),
      ),
      locationChanged: false,
      address: "",
      loaded: false,
      icon: null,
      addressShort: "",
      savingAddress: false,
      success: false,
      error: false,
      noInternet: false,
      finalAddress: null,
      message: "",
      validLocation: false,
    );
  }

  MapState copyWith({
    Set<Marker> markers,
    LatLng coords,
    bool loading,
    CameraPosition cameraPosition,
    bool locationChanged,
    String address,
    bool loaded,
    BitmapDescriptor icon,
    String addressShort,
    bool saving,
    bool success,
    bool error,
    bool noInternet,
    AddressModel finalAddress,
    String message,
    bool valid,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      coords: coords ?? this.coords,
      loading: loading ?? this.loading,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      locationChanged: locationChanged ?? this.locationChanged,
      address: address ?? this.address,
      loaded: loaded ?? this.loaded,
      icon: icon ?? this.icon,
      addressShort: addressShort ?? this.addressShort,
      savingAddress: saving ?? this.savingAddress,
      error: error ?? this.error,
      success: success ?? this.success,
      noInternet: noInternet ?? this.noInternet,
      finalAddress: finalAddress ?? this.finalAddress,
      message: message ?? this.message,
      validLocation: valid ?? this.validLocation,
    );
  }

  @override
  List<Object> get props => [
        markers,
        coords,
        loading,
        cameraPosition,
        locationChanged,
        address,
        loaded,
        icon,
        addressShort,
        success,
        error,
        savingAddress,
        noInternet,
        finalAddress,
        message,
        validLocation,
      ];
}
