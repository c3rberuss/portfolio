import 'package:equatable/equatable.dart';

abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
}

class FetchImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class RefreshImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class LoadMoreImagesEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class LoadImagesFromCategoryEvent extends ImagesEvent {
  final String category;

  LoadImagesFromCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class SearchImagesEvent extends ImagesEvent {
  final String query;

  SearchImagesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreResultsEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}

class ClearResultsEvent extends ImagesEvent {
  @override
  List<Object> get props => [];
}
