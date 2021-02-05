import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class FetchCategoriesEvent extends CategoriesEvent {
  @override
  List<Object> get props => [];
}

class ChangeCategorySelectedEvent extends CategoriesEvent {
  final int index;

  ChangeCategorySelectedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class InitialCategoryEvent extends CategoriesEvent{
  @override
  List<Object> get props => [];

}
