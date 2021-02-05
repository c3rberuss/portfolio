import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class FetchDataEvent extends CategoriesEvent {
  @override
  List<Object> get props => [];
}

class RefreshDataEvent extends CategoriesEvent {
  @override
  List<Object> get props => [];
}
