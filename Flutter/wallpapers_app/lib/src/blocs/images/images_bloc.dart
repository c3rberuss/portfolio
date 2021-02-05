import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:wallpapers/src/blocs/images/images_state.dart';
import 'package:wallpapers/src/models/image_model.dart';
import 'package:wallpapers/src/models/images_response.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import './bloc.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final DataRepository _repository;

  ImagesBloc(this._repository);

  @override
  ImagesState get initialState => ImagesState.initial();

  @override
  Stream<ImagesState> mapEventToState(
    ImagesEvent event,
  ) async* {
    if (event is FetchImagesEvent) {
      yield state.copyWith(fetching: true);
      yield* _mapRequest();
    } else if (event is LoadMoreImagesEvent) {
      if (state.page <= state.totalPages) {
        yield* _mapRequest(loadMore: true, page: state.page + 1, category: state.category);
      } else {
        yield state.copyWith(loadingMoreFinalized: true);
      }

      yield state.copyWith(loadingMoreFinalized: false);
    } else if (event is RefreshImagesEvent) {
      yield state.copyWith(refreshingFinalized: false, page: 1);
      yield* _mapRequest(refresh: true, category: state.category);
    } else if (event is LoadImagesFromCategoryEvent) {
      yield state.copyWith(
        totalPages: 0,
        page: 1,
        fetching: true,
        fetchingFinalized: false,
        refreshingFinalized: false,
        refreshing: false,
      );

      yield* _mapRequest(category: event.category);
    } else if (event is SearchImagesEvent) {
      if (event.query.isNotEmpty) {
        yield state.copyWith(
          pageSearch: 1,
          totalPagesSearch: 0,
          imagesSearch: BuiltList<ImageModel>(),
          query: "",
        );

        print("SEARCH");

        yield* _mapRequestSearch(event.query);
      }
    } else if (event is LoadMoreResultsEvent) {

      print("LOAD MORE");
      if (state.pageSearch <= state.totalPagesSearch) {
        yield state.copyWith(pageSearch: state.pageSearch + 1);
        yield* _mapRequestSearch(state.query, state.pageSearch, true);
      } else {
        yield state.copyWith(loadingMoreResultsFinalized: true);
      }
    } else if (event is ClearResultsEvent) {
      yield state.copyWith(
        pageSearch: 1,
        totalPagesSearch: 0,
        imagesSearch: BuiltList<ImageModel>(),
        query: "",
      );
    }
  }

  Stream<ImagesState> _map404() async* {
    yield state.copyWith(
      refreshingFinalized: true,
      loadingMoreFinalized: true,
      fetching: false,
      fetchingFinalized: true,
      page: 1,
      totalPages: 0,
    );
  }

  Stream<ImagesState> _mapRequest(
      {String category = "", int page = 1, bool refresh = false, bool loadMore = false}) async* {
    try {
      ImagesResponse response;

      if (category.isEmpty) {
        response = await _repository.fetchImages(page, refresh: true);
      } else {
        response = await _repository.fetchCategory(category, page, refresh: true);
      }

      yield state.copyWith(category: category);

      print(response);

      if (response.statusCode == 200) {
        if (!refresh && !loadMore) {
          yield* _mapFetch(response);
        } else if (loadMore) {
          yield* _mapLoadMore(response);
        } else if (refresh) {
          yield* _mapRefresh(response);
        }
      } else if (response.statusCode == 404) {
        yield* _map404();
      } else {
        print("Session Expired");
      }
    } on DioError catch (error) {
      yield* _mapDioError(error);
    }
  }

  Stream<ImagesState> _mapFetch(ImagesResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      images: response.data,
      page: 1,
      totalPages: response.pages,
    );
  }

  Stream<ImagesState> _mapLoadMore(ImagesResponse response) async* {
    yield state.copyWith(
      loadingMoreFinalized: true,
      page: state.page + 1,
      images: state.images.rebuild((c) => c.addAll(response.data)),
    );
  }

  Stream<ImagesState> _mapRefresh(ImagesResponse response) async* {
    yield state.copyWith(
      refreshingFinalized: true,
      images: response.data,
      page: 1,
      totalPages: response.pages,
    );
  }

  Stream<ImagesState> _mapRequestSearch(String query, [int page = 1, bool loadMore = false]) async* {
    try {
      yield state.copyWith(query: query);
     if(loadMore)  yield state.copyWith(loadingMoreResultsFinalized: false);

      if (!loadMore) yield state.copyWith(fetchingSearch: true, fetchingResultsFinalized: false);

      final response = await _repository.searchImages(query, page, refresh: true);

      print("QUERY: $query");
      print(response);

      if (response.statusCode == 200) {
        if (loadMore) {
          yield state.copyWith(
            query: query,
            imagesSearch: state.imagesSearch.rebuild((c) => c.addAll(response.data)),
            loadingMoreResultsFinalized: true,
          );
        } else {
          yield state.copyWith(
            query: query,
            imagesSearch: response.data,
            totalPagesSearch: response.pages,
            pageSearch: 1,
            fetchingSearch: false,
            fetchingResultsFinalized: true,
          );
        }
      }
    } on DioError catch (error) {
      yield* _mapDioError(error);
    }
  }

  Stream<ImagesState> _mapDioError(DioError error) async* {
    if (error.type == DioErrorType.DEFAULT) {
      yield state.copyWith(internetError: true);
    } else if (error.type == DioErrorType.RESPONSE) {
      yield state.copyWith(providerError: true);
    }
  }
}
