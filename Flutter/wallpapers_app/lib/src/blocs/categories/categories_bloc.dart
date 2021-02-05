import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapers/src/blocs/categories/categories_state.dart';
import 'package:wallpapers/src/blocs/images/images_bloc.dart';
import 'package:wallpapers/src/blocs/images/images_event.dart';
import 'package:wallpapers/src/models/categories_response.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import './bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final DataRepository _repository;
  final BuildContext _context;

  CategoriesBloc(this._repository, this._context);

  @override
  CategoriesState get initialState => CategoriesState.initial();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is FetchCategoriesEvent) {
      yield state.copyWith(fetching: true);
      yield* _mapRequest();
    } else if (event is ChangeCategorySelectedEvent) {
      yield state.copyWith(manualChange: false, externalChange: false);
      yield state.copyWith(
        categorySelected: event.index,
        categorySelectedAnt: state.categorySelected,
        externalChange: false,
        manualChange: true,
      );
    } else if (event is InitialCategoryEvent) {
      yield state.copyWith(externalChange: false, manualChange: false);
      yield state.copyWith(
        categorySelected: 0,
        categorySelectedAnt: 0,
        externalChange: true,
        manualChange: false,
      );
    }
  }

  Stream<CategoriesState> _map404() async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
    );
  }

  Stream<CategoriesState> _mapRequest({bool refresh = false}) async* {
    final response = await _repository.fetchCategories(refresh: true);

    if (response.statusCode == 200) {
      yield* _mapFetch(response);
    } else if (response.statusCode == 404) {
      yield* _map404();
    }
  }

  Stream<CategoriesState> _mapFetch(CategoriesResponse response) async* {
    yield state.copyWith(
      fetching: false,
      fetchingFinalized: true,
      categories: response.data,
    );
  }
}
