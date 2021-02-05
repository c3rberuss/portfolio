import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();
}

class FetchProductsEvent extends ProductsEvent {
  final int categoryId;

  FetchProductsEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class RefreshProductsEvent extends ProductsEvent {
  final int categoryId;

  RefreshProductsEvent(this.categoryId);

  @override
  List<Object> get props => [];
}

class LoadMoreProductsEvent extends ProductsEvent {
  final int categoryId;

  LoadMoreProductsEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class ClearProductsStateEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class SearchProductsEvent extends ProductsEvent {
  final String query;

  SearchProductsEvent(this.query);

  @override
  List<Object> get props => [this.query];
}

class RefreshResultProductsEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class LoadMoreSearchProductsEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class ClearSearchEvent extends ProductsEvent {
  @override
  List<Object> get props => [];
}

class AddToWishListEvent extends ProductsEvent {
  final int id;

  AddToWishListEvent(this.id);

  @override
  List<Object> get props => [id];
}
