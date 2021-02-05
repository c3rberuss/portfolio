import 'package:app/app/framework/pagination_controller.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/store.dart';
import 'package:app/core/interactors/api_interactors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class StoresController extends PaginationController<Store, StoresResponse> {
  FetchStoresInt _fetchStores;
  RxDouble bottom = 0.0.obs;
  int _serviceId = 0;

  StoresController({@required FetchStoresInt fetchStores}) {
    this._fetchStores = fetchStores;
  }

  void toggleBottomPosition() {
    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      bottom.value = -100;
    } else if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
      bottom.value = -0.0;
    }
  }

  void initialize(int serviceId) {
    _serviceId = serviceId;
    fetchData();
  }

  @override
  Future<Resource<StoresResponse>> fetch(int page, bool refresh) async {
    return await _fetchStores(_serviceId, page: page, refresh: refresh);
  }
}
