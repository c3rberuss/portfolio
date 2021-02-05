import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/src/models/category_model.dart';

class CategoriesState extends Equatable {
  final bool fetching;
  final bool fetchingFinalized;
  final int categorySelected;
  final int categorySelectedAnt;
  final bool manualChange;
  final bool externalChange;
  final BuiltList<CategoryModel> categories;

  CategoriesState({
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.categorySelected,
    @required this.categories,
    @required this.categorySelectedAnt,
    @required this.manualChange,
    @required this.externalChange,
  });

  factory CategoriesState.initial() {
    return CategoriesState(
      fetching: true,
      fetchingFinalized: false,
      categorySelected: 0,
      categorySelectedAnt: 0,
      manualChange: false,
      externalChange: false,
      categories: BuiltList<CategoryModel>(),
    );
  }

  CategoriesState copyWith({
    bool fetching,
    bool refreshing,
    bool fetchingFinalized,
    int categorySelected,
    int categorySelectedAnt,
    bool loadingMore,
    bool loadingMoreFinalized,
    bool manualChange,
    bool externalChange,
    BuiltList<CategoryModel> categories,
  }) {
    return CategoriesState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      categorySelected: categorySelected ?? this.categorySelected,
      categories: categories ?? this.categories,
      categorySelectedAnt: categorySelectedAnt ?? this.categorySelectedAnt,
      manualChange: manualChange ?? this.manualChange,
      externalChange: externalChange ?? this.externalChange,
    );
  }

  @override
  List<Object> get props => [
    fetching,
    categorySelected,
    fetchingFinalized,
    categories,
    categorySelectedAnt,
    manualChange,
    externalChange,
  ];
}
