import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:megalibreria/src/models/categories/categories_response.dart';
import 'package:megalibreria/src/repositories/data_repository.dart';
import './bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final DataRepository _repository;

  CategoriesBloc(this._repository);

  @override
  CategoriesState get initialState => CategoriesState.initial();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is FetchCategoriesEvent) {
      yield state.copyWith(fetching: true);
      yield* _mapRequest();
    } else if (event is LoadMoreCategoriesEvent) {
      if (state.page <= state.totalPages) {
        yield* _mapRequest(loadMore: true, page: state.page + 1);
      } else {
        yield state.copyWith(loadingMoreFinalized: true);
      }

      yield state.copyWith(loadingMoreFinalized: false);
    } else if (event is RefreshCategoriesEvent) {
      yield state.copyWith(refreshingFinalized: false);
      yield* _mapRequest(refresh: true, page: 1);
    }
  }

  Stream<CategoriesState> _map404() async* {
    yield state.copyWith(
      refreshingFinalized: true,
      totalPages: 1,
      loadingMoreFinalized: true,
      fetching: false,
      fetchingFinalized: true,
      page: 1,
    );
  }

  Stream<CategoriesState> _mapRequest(
      {int page = 1, bool refresh = false, bool loadMore = false}) async* {
    try {
      final response = await _repository.fetchCategories(page, true);
      if (response.code == 200) {
        if (!refresh && !loadMore) {
          yield* _mapFetch(response);
        } else if (loadMore) {
          yield* _mapLoadMore(response);
        } else if (refresh) {
          yield* _mapRefresh(response);
        }
      } else if (response.code == 404) {
        yield* _map404();
      } else {
        print("Session Expired");
      }
    } on DioError catch (error) {
      print(error);
      if (error.type == DioErrorType.DEFAULT) {
        yield state.copyWith(
          noInternet: true,
          refreshing: false,
          loadingMore: false,
          loadingMoreFinalized: true,
          refreshingFinalized: true,
          fetching: false,
          fetchingFinalized: true,
        );
        yield state.copyWith(noInternet: false);
      }
    }
  }

  Stream<CategoriesState> _mapFetch(CategoriesResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      categories: response.body.data,
      page: response.body.page,
      totalPages: response.body.totalPages,
    );
  }

  Stream<CategoriesState> _mapLoadMore(CategoriesResponse response) async* {
    yield state.copyWith(
      loadingMoreFinalized: true,
      page: response.body.page,
      totalPages: response.body.totalPages,
      categories: state.categories.rebuild((c) => c.addAll(response.body.data)),
    );
  }

  Stream<CategoriesState> _mapRefresh(CategoriesResponse response) async* {
    yield state.copyWith(
      refreshingFinalized: true,
      categories: response.body.data,
      totalPages: response.body.totalPages,
      page: response.body.page,
    );
  }
}
