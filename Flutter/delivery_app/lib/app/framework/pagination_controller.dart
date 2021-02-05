import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

abstract class PaginationController<T, S> extends GetxController {
  final ScrollController scrollController = ScrollController();
  Resource _status = Loading();

  Resource get status => _status;
  int _page = 0;
  int _totalPages = 0;
  final RxBool isLoadingMore = false.obs;

  int get currentPage => _page;

  int get totalPages => _totalPages;
  final List<T> data = [];

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(_loadMore);
  }

  Future<Resource<S>> fetch(int page, bool refresh);

  Future<void> fetchData({bool loadMore = false, bool refresh = false}) async {
    Resource<S> result;

    if ((!refresh && !loadMore) || refresh) {
      if (!refresh) _status = Loading();
      result = await fetch(_page, refresh);
    } else if (loadMore && _page + 1 < _totalPages) {
      result = await fetch(_page, false);
    }

    if (result != null && result is Success<S>) {
      if (refresh) {
        _page = 0;
        data.clear();
        data.addAll((result.data as ResponsePagination<List<T>>).data);
        update(['data']);
      } else if (loadMore) {
        if (_page < _totalPages) {
          data.addAll((result.data as ResponsePagination<List<T>>).data);
          isLoadingMore.value = false;
          _page++;
          update(['data']);
        }
      } else {
        data.addAll((result.data as ResponsePagination<List<T>>).data);
        _status = Success();
        _totalPages = (result.data as ResponsePagination<List<T>>).pagination.totalPages;
        update(['builder']);
      }
    } else if (result != null && result is Failure<S, DioError>) {
      _status = Failure();
      update(['builder']);
    }
  }

  Future<void> _loadMore() async {
    if (scrollController.position.pixels > scrollController.position.maxScrollExtent * 0.9 &&
        data.isNotEmpty &&
        !isLoadingMore.value &&
        _page + 1 < _totalPages) {
      isLoadingMore.value = true;
      fetchData(loadMore: true);
    }
  }

  Future<void> refreshData() async {
    await fetchData(refresh: true);
  }
}
