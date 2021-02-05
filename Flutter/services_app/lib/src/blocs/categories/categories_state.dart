import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:services/src/models/category_model.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class LoadingDataState extends CategoriesState {
  @override
  List<Object> get props => [];
}

class DataObtainedState extends CategoriesState {
  final BuiltList<CategoryModel> categories;

  DataObtainedState(this.categories);

  @override
  List<Object> get props => [categories];
}

class EmptyDataState extends CategoriesState {
  final String message;

  EmptyDataState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorFetchDataState extends CategoriesState {
  final String error;

  ErrorFetchDataState(this.error);

  @override
  List<Object> get props => [error];
}

class ShowServicesState extends CategoriesState {
  final int categoryId;

  ShowServicesState(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class RefreshDataCompleteState extends CategoriesState {
  @override
  List<Object> get props => [];
}
