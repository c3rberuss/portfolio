import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:megalibreria/src/models/categories/category_model.dart';

class CategoriesState extends Equatable {
  final bool fetching;
  final bool fetchingFinalized;
  final bool refreshingFinalized;
  final bool loadingMoreFinalized;
  final int page;
  final int totalPages;
  final bool noInternet;
  final BuiltList<CategoryModel> categories;

  CategoriesState({
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.refreshingFinalized,
    @required this.loadingMoreFinalized,
    @required this.categories,
    @required this.page,
    @required this.totalPages,
    @required this.noInternet,
  });

  factory CategoriesState.initial() {
    return CategoriesState(
      fetching: true,
      fetchingFinalized: false,
      refreshingFinalized: false,
      loadingMoreFinalized: false,
      categories: BuiltList<CategoryModel>(),
      page: 1,
      totalPages: 0,
      noInternet: false,
    );
  }

  CategoriesState copyWith({
    bool fetching,
    bool refreshing,
    bool fetchingFinalized,
    bool refreshingFinalized,
    bool loadingMore,
    bool loadingMoreFinalized,
    BuiltList<CategoryModel> categories,
    int page,
    int totalPages,
    bool noInternet,
  }) {
    return CategoriesState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      refreshingFinalized: refreshingFinalized ?? this.refreshingFinalized,
      loadingMoreFinalized: loadingMoreFinalized ?? this.loadingMoreFinalized,
      categories: categories ?? this.categories,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      noInternet: noInternet ?? this.noInternet,
    );
  }

  @override
  List<Object> get props => [
        fetching,
        categories,
        refreshingFinalized,
        fetchingFinalized,
        loadingMoreFinalized,
        page,
        totalPages,
        noInternet,
      ];
}
