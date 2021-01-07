import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class FetchCategoriesEvent extends CategoriesEvent{
  @override
  List<Object> get props => [];
}

class RefreshCategoriesEvent extends CategoriesEvent{
  @override
  List<Object> get props => [];
}

class LoadMoreCategoriesEvent extends CategoriesEvent{
  @override
  List<Object> get props => [];
}