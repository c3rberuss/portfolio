import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class GetLocationEvent extends MapEvent {
  @override
  List<Object> get props => [];
}

class SetInitialAddress extends MapEvent {
  final double latitude;
  final double longitude;
  final String address;

  SetInitialAddress({
    @required this.latitude,
    @required this.longitude,
    @required this.address,
  });

  @override
  List<Object> get props => [address, latitude, longitude];
}

class ChangeCameraPositionEvent extends MapEvent {
  final LatLng position;

  ChangeCameraPositionEvent(this.position);

  @override
  List<Object> get props => [position];
}

class GetAddressEvent extends MapEvent {
  @override
  List<Object> get props => [];
}

class SaveAddressEvent extends MapEvent {
  final AddressModel address;

  SaveAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}
