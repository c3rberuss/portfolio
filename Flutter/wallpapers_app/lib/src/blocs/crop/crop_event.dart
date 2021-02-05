import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
//import 'package:image_crop/image_crop.dart' as crop;

abstract class CropEvent extends Equatable {
  const CropEvent();
}

class SetImageAsWallpaperEvent extends CropEvent {
  final Rect cropArea;
  final String url;

  SetImageAsWallpaperEvent(this.cropArea, this.url);

  @override
  List<Object> get props => [cropArea, url];
}

class ChangeHomeEvent extends CropEvent {
  final bool value;

  ChangeHomeEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeLockEvent extends CropEvent {
  final bool value;

  ChangeLockEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeBothEvent extends CropEvent {
  final bool value;

  ChangeBothEvent(this.value);

  @override
  List<Object> get props => [value];
}
