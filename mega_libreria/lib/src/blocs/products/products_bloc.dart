import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:megalibreria/src/models/products/product_model.dart';
import 'package:megalibreria/src/models/products/products_response.dart';
import 'package:megalibreria/src/repositories/data_repository.dart';
import 'package:megalibreria/src/repositories/user_repository.dart';
import './bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final DataRepository _repository;
  final UserRepository _userRepository;

  ProductsBloc(this._repository, this._userRepository);

  @override
  ProductsState get initialState => ProductsState.initial();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is FetchProductsEvent) {
      yield state.copyWith(fetching: true);
      yield* _mapRequest(id: event.categoryId);
    } else if (event is LoadMoreProductsEvent) {
      if (state.page + 1 <= state.totalPages) {
        yield* _mapRequest(id: event.categoryId, loadMore: true, page: state.page + 1);
      } else {
        print("AQUI");
        yield state.copyWith(loadingMoreFinalized: true);
        yield state.copyWith(loadingMoreFinalized: false);
      }
    } else if (event is RefreshProductsEvent) {
      yield state.copyWith(refreshingFinalized: false);
      yield* _mapRequest(refresh: true, id: event.categoryId);
    } else if (event is ClearProductsStateEvent) {
      yield ProductsState.initial();
    }else if(event is SearchProductsEvent){

      if (event.query.isNotEmpty) {
        yield state.copyWith(
          pageSearch: 1,
          totalPagesSearch: 0,
          search: BuiltList<ProductModel>(),
          query: "",
        );

        yield* _mapRequestSearch(event.query);
      }

    }else if(event is LoadMoreSearchProductsEvent){

      print("LOAD MORE");
      if (state.pageSearch <= state.totalPagesSearch) {
        yield state.copyWith(pageSearch: state.pageSearch + 1);
        yield* _mapRequestSearch(state.query, state.pageSearch, true);
      } else {
        yield state.copyWith(loadingMoreFinalizedSearch: true);
      }

    }else if (event is ClearSearchEvent) {
      yield state.copyWith(
        pageSearch: 1,
        totalPagesSearch: 0,
        search: BuiltList<ProductModel>(),
        query: "",
      );
    }else if(event is AddToWishListEvent){

      final response = await _userRepository.addToWishList(event.id);
      print(response);

    }
  }

  Stream<ProductsState> _map404() async* {
    yield state.copyWith(
      refreshingFinalized: true,
      totalPages: 1,
      loadingMoreFinalized: true,
      fetching: false,
      fetchingFinalized: true,
      page: 1,
    );
  }

  Stream<ProductsState> _mapRequest(
      {int id, int page = 1, bool refresh = false, bool loadMore = false}) async* {
    try {
      final response = await _repository.fetchProducts(id, page, true);
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
      if (error.type == DioErrorType.DEFAULT) {
        yield state.copyWith(
          noInternet: true,
          fetchingFinalized: true,
          fetching: false,
          loadingMoreFinalized: true,
          refreshingFinalized: true,
        );

        yield state.copyWith(noInternet: false);
      }
    }
  }

  Stream<ProductsState> _mapFetch(ProductsResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      products: response.body.data,
      page: response.body.page,
      totalPages: response.body.totalPages,
    );
  }

  Stream<ProductsState> _mapLoadMore(ProductsResponse response) async* {
    final products = state.products.rebuild((c) => c.addAll(response.body.data));

    yield state.copyWith(
      loadingMoreFinalized: true,
      page: state.page + 1,
      products: products,
    );
  }

  Stream<ProductsState> _mapRefresh(ProductsResponse response) async* {
    yield state.copyWith(
      refreshingFinalized: true,
      products: response.body.data,
      totalPages: response.body.totalPages,
      page: response.body.page,
    );
  }

  Stream<ProductsState> _mapRequestSearch(String query, [int page = 1, bool loadMore = false]) async* {
    try {
      yield state.copyWith(query: query);
      if(loadMore)  yield state.copyWith(loadingMoreFinalizedSearch: false);

      if (!loadMore) yield state.copyWith(fetchingSearch: true, fetchingFinalizedSearch: false);

      final response = await _repository.searchProducts(query, page, true);

      print("QUERY: $query");

      if (response.code == 200) {
        if (loadMore) {
          yield state.copyWith(
            query: query,
            search: state.searchProducts.rebuild((c) => c.addAll(response.body.data)),
            loadingMoreFinalizedSearch: true,
          );
        } else {
          yield state.copyWith(
            query: query,
            search: response.body.data,
            totalPagesSearch: response.body.totalPages,
            pageSearch: response.body.page,
            fetchingSearch: false,
            fetchingFinalizedSearch: true,
          );
        }
      }else{
        yield state.copyWith(
          search: BuiltList<ProductModel>(),
          totalPagesSearch: 1,
          pageSearch: 1,
          fetchingSearch: false,
          fetchingFinalizedSearch: true,
        );
      }
    } on DioError catch (error) {
      print(error);
      //yield* _mapDioError(error);
    }
  }


}
