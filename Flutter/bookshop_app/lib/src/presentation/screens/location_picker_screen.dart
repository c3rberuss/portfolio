import 'dart:async';
import 'dart:ui';

import 'package:bookshop/src/blocs/map/bloc.dart';
import 'package:bookshop/src/models/addresses/address_model.dart';
import 'package:bookshop/src/models/args/location_picker_args.dart';
import 'package:bookshop/src/presentation/widgets/change_address_dialog.dart';
import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  final LocationPickerArgs data;

  LocationPicker(this.data);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  // ignore: close_sinks
  MapBloc _bloc;
  Completer<GoogleMapController> _controller = Completer();
  ThemeRepository _theme;
  bool initial;

  @override
  void initState() {
    super.initState();
    _theme = RepositoryProvider.of<ThemeRepository>(context);
    _bloc = MapBloc();

    initial = false;

    if (widget.data.latitude != null &&
        widget.data.longitude != null &&
        widget.data.address.isNotEmpty) {
      initial = true;
      _bloc.add(SetInitialAddress(
        latitude: widget.data.latitude,
        longitude: widget.data.longitude,
        address: widget.data.address,
      ));
    } else {
      _bloc.add(GetLocationEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        iconTheme: ThemeData.light().iconTheme.copyWith(color: GFColors.PRIMARY),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          "Seleccione su ubicación",
          style: TextStyle(color: GFColors.PRIMARY, fontSize: 27),
        ),
        actions: <Widget>[
          BlocBuilder<MapBloc, MapState>(
            bloc: _bloc,
            builder: (BuildContext context, MapState state) {
              return IconButton(
                icon: Icon(Icons.check),
                onPressed: state.validLocation
                    ? () async {
                        final data = await showDialog(
                          context: context,
                          barrierDismissible: false,
                          child: ChangeAddressDialog(state.addressShort),
                        );

                        if (data != null && data is AddressModel) {
                          print(data);
                          _bloc.add(SaveAddressEvent(data));
                        }
                      }
                    : null,
              );
            },
          )
        ],
        backgroundColor: GFColors.WHITE,
      ),
      body: BlocConsumer<MapBloc, MapState>(
        bloc: _bloc,
        listener: (BuildContext context, MapState state) async {
          if (state.noInternet) {
            /* noInternetConnection(context, (){
              if(_progressDialog.isShowing()){
                _progressDialog.hide();
              }
            });*/
          }

          if (state.error) {
            showError(context, state.message, "Error");
          }

          if (state.success) {
            if (state.finalAddress != null) {
              Navigator.pop(context, state.finalAddress);
            }
          }
        },
        builder: (BuildContext context, MapState state) {
          if (state.loaded) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  circles: Set<Circle>()
                    ..add(
                      Circle(
                        circleId: CircleId("area"),
                        center: LatLng(13.479613, -88.175669),
                        radius: 5000,
                        strokeWidth: 1,
                        strokeColor: _theme.palette.primary,
                        fillColor: _theme.palette.primary.withOpacity(0.1),
                      ),
                    ),
                  zoomControlsEnabled: false,
                  //markers: state.markers,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: state.cameraPosition,
                  onCameraMove: (camPosition) async {
                    if (initial) {
                      initial = false;
                    } else {
                      _bloc.add(ChangeCameraPositionEvent(camPosition.target));
                    }
                  },
                  onCameraIdle: () {
                    _bloc.add(GetAddressEvent());
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Positioned(
                  child: Image.asset(
                    "assets/icons/marker.png",
                    scale: 2.5,
                  ),
                  left: screenWidth(context) * 0.4,
                  right: screenWidth(context) * 0.4,
                  bottom: screenHeight(context) * 0.405,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  left: 4,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  _theme.palette.primary,
                                  _theme.palette.info,
                                ],
                              ),
                            ),
                            child: Center(
                              child: state.locationChanged
                                  ? CircularProgressIndicator()
                                  : Text(
                                      state.address,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
