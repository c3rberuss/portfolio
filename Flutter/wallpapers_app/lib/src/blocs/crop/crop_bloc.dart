import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
//import 'package:image_crop/image_crop.dart' as crop;
import 'dart:math' as math;

import 'bloc.dart';


class CropBloc extends Bloc<CropEvent, CropState> {

  final BuildContext _context;


  CropBloc(this._context);

  @override
  CropState get initialState => CropState.initial();

  @override
  Stream<CropState> mapEventToState(
    CropEvent event,
  ) async* {
   if (event is SetImageAsWallpaperEvent) {

      yield* _mapSetAsWallpaper(event.cropArea, event.url);

    }else if(event is ChangeHomeEvent){
      yield state.copyWith(
        home: event.value,
        lock: false,
        both: false
      );
    }else if(event is ChangeLockEvent){
      yield state.copyWith(
          lock: event.value,
          home: false,
          both: false
      );
    }else if(event is ChangeBothEvent){
      yield state.copyWith(
          both: event.value,
          lock: false,
          home: false
      );
    }
  }


  Stream<CropState> _mapSetAsWallpaper(Rect cropArea, String url) async*{

    //await crop.ImageCrop.requestPermissions();


   /* final options = await crop.ImageCrop.getImageOptions(file: File(url));
    print("IMAGE SIZE = ${options.width} x ${options.height} ");

    final croppedFile = await crop.ImageCrop.cropImage(
        file: File(url),
        area: cropArea,
        //scale: calcScale(srcWidth: options.width*1.0, srcHeight: options.height*1.0)
    );

    print(croppedFile.path);

    int location = _getLocation();

    if(location == 3){

      final String result = await WallpaperManager.setWallpaperFromFile(
          croppedFile.path, WallpaperManager.HOME_SCREEN);
      print(result);

      final String result2 = await WallpaperManager.setWallpaperFromFile(
          croppedFile.path, WallpaperManager.LOCK_SCREEN);
      print(result2);

    }else{
      final String result = await WallpaperManager.setWallpaperFromFile(
          croppedFile.path, location);
      print(result);

    }

    final originalFile = File(url);

    if(await originalFile.exists()){
      originalFile.delete();
      print("DELETED");
    }
    yield state.copyWith(success: true);
*/
/*    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      compressQuality: 90,
      compressFormat: ImageCompressFormat.jpg,
      cropStyle: CropStyle.rectangle,
      aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 16),
      androidUiSettings: AndroidUiSettings(
        backgroundColor: _palette.background,
        toolbarTitle: 'Crop Image',
        toolbarColor: _palette.background,
        toolbarWidgetColor: _palette.secondary,
        dimmedLayerColor: _palette.background,
        statusBarColor: _palette.background,
        activeControlsWidgetColor:  _palette.secondary,
        initAspectRatio: CropAspectRatioPreset.ratio16x9,
        lockAspectRatio: true,
      ),
    );

    if(croppedFile != null){
      print(croppedFile.path);

      int location = _getLocation();

      if(location == 3){

        final String result = await WallpaperManager.setWallpaperFromFile(
            croppedFile.path, WallpaperManager.HOME_SCREEN);
        print(result);

        final String result2 = await WallpaperManager.setWallpaperFromFile(
            croppedFile.path, WallpaperManager.LOCK_SCREEN);
        print(result2);

      }else{
        final String result = await WallpaperManager.setWallpaperFromFile(
            croppedFile.path, location);
        print(result);

      }

      final originalFile = File(path);

      if(await originalFile.exists()){
        originalFile.delete();
        print("DELETED");
      }
      yield state.copyWith(success: true);
    }*/

    //yield state.copyWith(success: false, error: false);
  }

  double calcScale({
    double srcWidth,
    double srcHeight,
  }) {
    var scaleW = srcWidth / 1920;
    var scaleH = srcHeight / 1080;

    var scale = math.max(1.0, math.min(scaleW, scaleH));

    return scale;
  }

  int _getLocation(){
    int location;
    if(state.home) location = WallpaperManager.HOME_SCREEN;
    if(state.lock) location = WallpaperManager.LOCK_SCREEN;
    if(state.both) location = 3;

    return location;
  }
}
