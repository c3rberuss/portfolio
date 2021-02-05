import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:wallpapers/src/blocs/image/image_state.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/utils/palette.dart';
import 'package:wallpapers/src/utils/screen_utils.dart';
import './bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final DataRepository _repository;
  final Palette _palette;
  final BuildContext _context;

  ImageBloc(this._repository, this._palette, this._context);

  @override
  ImageState get initialState => ImageState.initial();

  @override
  Stream<ImageState> mapEventToState(
    ImageEvent event,
  ) async* {
    if (event is FetchImageEvent) {
      try {
        final response = await _repository.fetchImage(event.category, event.name, refresh: true);

        if (response.statusCode == 200) {
          yield state.copyWith(
            fetching: false,
            fetchingFinalize: true,
            image: response.data,
          );
        }
      } on DioError catch (error) {
        yield* _mapDioError(error);
      }
    } else if (event is SetImageAsWallpaperEvent) {
      yield* _mapSetAsWallpaper();
    } else if (event is DownloadImageEvent) {
     /* yield state.copyWith(downloading: true);

      final path = await _repository.downloadImage(state.image.url, state.image.name, (progress) {
        print("PROGRESS: ${progress.toStringAsFixed(2)}%");
      });

      yield state.copyWith(downloading: false);*/

    } else if (event is ChangeHomeEvent) {
      yield state.copyWith(home: event.value, lock: false, both: false);
    } else if (event is ChangeLockEvent) {
      yield state.copyWith(lock: event.value, home: false, both: false);
    } else if (event is ChangeBothEvent) {
      yield state.copyWith(both: event.value, lock: false, home: false);
    }
  }

  Stream<ImageState> _mapSetAsWallpaper() async* {
    yield state.copyWith(downloading: true, success: false, error: false, url: "");

    final rootDirectory = await getApplicationDocumentsDirectory();

    try{

      final path = await _repository.downloadImage(state.image.url, state.image.name, (progress) {
        print("PROGRESS: ${progress.toStringAsFixed(2)}%");
      });

      //final options1 = await crop.ImageCrop.getImageOptions(file: File(path));
      //print("IMAGE SIZE = ${options1.width} x ${options1.height} ");

      final compressImage = await FlutterImageCompress.compressAndGetFile(
        path,
        rootDirectory.path + "/compressed_" + p.basename(path),
        quality: 100,
        //inSampleSize: 1,
        minHeight: 1440,
        minWidth: 2560,
      );

      //final options = await crop.ImageCrop.getImageOptions(file: compressImage);
      //print("IMAGE COMPRESSED SIZE = ${options.width} x ${options.height} ");

      File(path).delete();

      print("IMAGE COMPRESSED ${compressImage.path}");

      yield state.copyWith(downloading: false);

      final File croppedFile = await ImageCropper.cropImage(
        sourcePath: compressImage.path,
        compressQuality: 100,
        compressFormat: ImageCompressFormat.jpg,
        cropStyle: CropStyle.rectangle,
        aspectRatio: CropAspectRatio(ratioX: screenWidth(_context), ratioY: screenHeight(_context)),
        androidUiSettings: AndroidUiSettings(
          backgroundColor: _palette.background,
          toolbarTitle: 'Crop Image',
          toolbarColor: _palette.background,
          toolbarWidgetColor: _palette.secondary,
          dimmedLayerColor: _palette.background,
          statusBarColor: _palette.background,
          activeControlsWidgetColor: _palette.secondary,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
      );

      if (croppedFile != null) {
        print(croppedFile.path);

        int location = _getLocation();

        if (location == 3) {
          final String result = await WallpaperManager.setWallpaperFromFile(
              croppedFile.path, WallpaperManager.HOME_SCREEN);
          print(result);

          final String result2 = await WallpaperManager.setWallpaperFromFile(
              croppedFile.path, WallpaperManager.LOCK_SCREEN);
          print(result2);
        } else {
          final String result =
          await WallpaperManager.setWallpaperFromFile(croppedFile.path, location);
          print(result);
        }

        final originalFile = File(path);

        if (await originalFile.exists()) {
          originalFile.delete();
          print("DELETED");
        }
        yield state.copyWith(success: true);
      }else{
        yield state.copyWith(error: true);
      }

      yield state.copyWith(downloading: false, success: false, error: false);

    }on DioError catch(error){
      yield* _mapDioError(error);
    }
  }

  int _getLocation() {
    int location;
    if (state.home) location = WallpaperManager.HOME_SCREEN;
    if (state.lock) location = WallpaperManager.LOCK_SCREEN;
    if (state.both) location = 3;

    return location;
  }

  Stream<ImageState> _mapDioError(DioError error) async*{
    if(error.type == DioErrorType.DEFAULT){
      yield state.copyWith(internetError: true);
    }else if(error.type == DioErrorType.RESPONSE){
      yield state.copyWith(providerError: true);
    }
  }
}
