import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:services/src/repositories/applications_repository_impl.dart';

import './bloc.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final ApplicationsRepositoryImpl _repository;

  @override
  ServicesState get initialState => LoadingServicesState();

  ServicesBloc(this._repository);

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    if (event is FetchServicesEvent) {
      yield LoadingServicesState();
      yield* _mapFetchServices(event.categoryId);
    } else if (event is RefreshServicesEvent) {
      yield* _mapFetchServices(event.categoryId, refresh: true);
    }
  }

  Stream<ServicesState> _mapFetchServices(int categoryId, {bool refresh = false}) async* {
    final response = await _repository.fetchServices(categoryId, refresh);
    if (response.code == 200) {
      if (response.data.length > 0) {
        if (refresh) yield RefreshServicesCompleted();
        yield ServicesObtainedState(response.data);
      } else {
        yield EmptyServicesState("This category doesn't have services.");
      }
    }
  }
}
