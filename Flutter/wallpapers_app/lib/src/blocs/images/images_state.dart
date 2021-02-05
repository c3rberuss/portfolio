import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wallpapers/src/models/image_model.dart';

class ImagesState extends Equatable {
  final bool fetching;
  final bool fetchingSearch;
  final bool fetchingFinalized;
  final bool fetchingResultsFinalized;
  final bool refreshingFinalized;
  final bool loadingMoreFinalized;
  final bool loadingMoreResultsFinalized;
  final int page;
  final int pageSearch;
  final int totalPages;
  final int totalPagesSearch;
  final String category;
  final String query;
  final bool providerError;
  final bool internetError;
  final BuiltList<ImageModel> images;
  final BuiltList<ImageModel> imagesSearch;

  ImagesState({
    @required this.fetching,
    @required this.fetchingSearch,
    @required this.fetchingFinalized,
    @required this.refreshingFinalized,
    @required this.loadingMoreFinalized,
    @required this.images,
    @required this.page,
    @required this.totalPagesSearch,
    @required this.pageSearch,
    @required this.totalPages,
    @required this.category,
    @required this.query,
    @required this.imagesSearch,
    @required this.loadingMoreResultsFinalized,
    @required this.fetchingResultsFinalized,
    @required this.internetError,
    @required this.providerError,
  });

  factory ImagesState.initial() {
    return ImagesState(
      fetching: true,
      fetchingFinalized: false,
      refreshingFinalized: false,
      loadingMoreFinalized: false,
      loadingMoreResultsFinalized: false,
      images: BuiltList<ImageModel>(),
      page: 1,
      totalPages: 0,
      pageSearch: 1,
      totalPagesSearch: 1,
      category: "",
      query: "",
      imagesSearch: BuiltList<ImageModel>(),
      fetchingSearch: false,
      fetchingResultsFinalized: false,
      internetError: false,
      providerError: false,
    );
  }

  ImagesState copyWith({
    bool fetching,
    bool refreshing,
    bool fetchingFinalized,
    bool refreshingFinalized,
    bool loadingMoreResultsFinalized,
    bool loadingMore,
    bool loadingMoreFinalized,
    BuiltList<ImageModel> images,
    BuiltList<ImageModel> imagesSearch,
    int page,
    int totalPages,
    int pageSearch,
    int totalPagesSearch,
    String category,
    String query,
    bool fetchingSearch,
    bool fetchingResultsFinalized,
    bool providerError,
    bool internetError,
  }) {
    return ImagesState(
      fetching: fetching ?? this.fetching,
      fetchingFinalized: fetchingFinalized ?? this.fetchingFinalized,
      refreshingFinalized: refreshingFinalized ?? this.refreshingFinalized,
      loadingMoreFinalized: loadingMoreFinalized ?? this.loadingMoreFinalized,
      images: images ?? this.images,
      imagesSearch: imagesSearch ?? this.imagesSearch,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      pageSearch: pageSearch ?? this.pageSearch,
      totalPagesSearch: totalPagesSearch ?? this.totalPagesSearch,
      category: category ?? this.category,
      query: query ?? this.query,
      loadingMoreResultsFinalized: loadingMoreResultsFinalized ?? this.loadingMoreResultsFinalized,
      fetchingSearch: fetchingSearch ?? this.fetchingSearch,
      fetchingResultsFinalized: fetchingResultsFinalized ?? this.fetchingResultsFinalized,
      providerError: providerError ?? this.providerError,
      internetError: internetError ?? this.internetError,
    );
  }

  @override
  List<Object> get props => [
        fetching,
        images,
        refreshingFinalized,
        fetchingFinalized,
        loadingMoreFinalized,
        page,
        totalPages,
        pageSearch,
        totalPagesSearch,
        category,
        query,
        imagesSearch,
        loadingMoreResultsFinalized,
        fetchingSearch,
        fetchingResultsFinalized,
        providerError,
        internetError,
      ];
}
