import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:services/src/repositories/applications_repository_impl.dart';

import './bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final ApplicationsRepositoryImpl _repository;

  CategoriesBloc(this._repository);

  @override
  CategoriesState get initialState => LoadingDataState();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is FetchDataEvent) {
      yield LoadingDataState();
      yield* _mapFetchData();
    } else if (event is RefreshDataEvent) {
      yield* _mapFetchData(refresh: true);
    }
  }

  Stream<CategoriesState> _mapFetchData({bool refresh = false}) async* {
    final response = await _repository.fetchCategories(refresh);

    if (response.code == 200) {
      if (response.data.length > 0) {
        if (refresh) yield RefreshDataCompleteState();
        yield DataObtainedState(response.data);
      } else {
        yield EmptyDataState("The list of categories is empty!");
      }
    }
  }
}
