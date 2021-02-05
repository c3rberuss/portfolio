import 'package:bookshop/src/models/products/product_model.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductsState extends Equatable {
  final bool fetching;
  final bool fetchingFinalized;
  final bool refreshingFinalized;
  final bool loadingMoreFinalized;
  final int page;
  final int totalPages;
  final BuiltList<ProductModel> products;
  final BuiltList<ProductModel> searchProducts;
  final bool noInternet;
  final bool fetchingSearch;
  final bool fetchingFinalizedSearch;
  final bool loadingMoreFinalizedSearch;
  final int pageSearch;
  final int totalPagesSearch;
  final String query;

  ProductsState({
    @required this.fetching,
    @required this.fetchingFinalized,
    @required this.refreshingFinalized,
    @required this.loadingMoreFinalized,
    @required this.products,
    @required this.page,
    @required this.totalPages,
    @required this.searchProducts,
    @required this.noInternet,
    @required this.fetchingFinalizedSearch,
    @required this.fetchingSearch,
    @required this.loadingMoreFinalizedSearch,
    @required this.pageSearch,
    @required this.totalPagesSearch,
    @required this.query,
  });

  factory ProductsState.initial() {
    return ProductsState(
      fetching: true,
      fetchingFinalized: false,
      refreshingFinalized: false,
      loadingMoreFinalized: false,
      products: BuiltList<ProductModel>(),
      page: 1,
      totalPages: 1,
      searchProducts: BuiltList<ProductModel>(),
      noInternet: false,
      fetchingFinalizedSearch: false,
      fetchingSearch: false,
      loadingMoreFinalizedSearch: false,
      pageSearch: 1,
      totalPagesSearch: 1,
      query: "",
    );
  }

  ProductsState copyWith({
    bool fetching,
    bool fetchingFinalized,
    bool refreshingFinalized,
    bool loadingMoreFinalized,
    BuiltList<ProductModel> products,
    int page,
    int totalPages,
    BuiltList<ProductModel> search,
    bool noInternet,
    bool fetchingSearch,
    bool fetchingFinalizedSearch,
    bool loadingMoreFinalizedSearch,
    int pageSearch,
    int totalPagesSearch,
    String query,
  }) {
    return ProductsState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      refreshingFinalized: refreshingFinalized ?? this.refreshingFinalized,
      loadingMoreFinalized: loadingMoreFinalized ?? this.loadingMoreFinalized,
      products: products ?? this.products,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      searchProducts: search ?? this.searchProducts,
      noInternet: noInternet ?? this.noInternet,
      fetchingSearch: fetchingSearch ?? this.fetchingSearch,
      fetchingFinalizedSearch: fetchingFinalizedSearch ?? this.fetchingFinalizedSearch,
      loadingMoreFinalizedSearch: loadingMoreFinalizedSearch ?? this.loadingMoreFinalizedSearch,
      pageSearch: pageSearch ?? this.pageSearch,
      totalPagesSearch: totalPagesSearch ?? this.totalPagesSearch,
      query: query ?? this.query,
    );
  }

  @override
  List<Object> get props => [
        fetching,
        products,
        refreshingFinalized,
        fetchingFinalized,
        loadingMoreFinalized,
        page,
        totalPages,
        searchProducts,
        noInternet,
        fetchingSearch,
        loadingMoreFinalizedSearch,
        fetchingFinalizedSearch,
        totalPagesSearch,
        pageSearch,
        query,
      ];
}
