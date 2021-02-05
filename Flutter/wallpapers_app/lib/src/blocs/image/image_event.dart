import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
}

class FetchImageEvent extends ImageEvent {
  final String name;
  final String category;

  FetchImageEvent(this.name, this.category);

  @override
  List<Object> get props => [name, category];
}

class SetImageAsWallpaperEvent extends ImageEvent {
  @override
  List<Object> get props => [];
}

class DownloadImageEvent extends ImageEvent {
  @override
  List<Object> get props => [];
}

class ChangeHomeEvent extends ImageEvent {
  final bool value;

  ChangeHomeEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeLockEvent extends ImageEvent {
  final bool value;

  ChangeLockEvent(this.value);

  @override
  List<Object> get props => [value];
}

class ChangeBothEvent extends ImageEvent {
  final bool value;

  ChangeBothEvent(this.value);

  @override
  List<Object> get props => [value];
}
