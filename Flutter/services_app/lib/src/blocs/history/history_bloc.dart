import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:services/src/models/applications_response.dart';
import 'package:services/src/repositories/user_repository_impl.dart';

import './bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final UserRepositoryImpl repository;

  HistoryBloc(this.repository);

  @override
  HistoryState get initialState => InitialHistoryState();

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    if (event is FetchHistoryEvent) {
      yield LoadingDataHistoryState();
      yield* _mapFetch(true);
    } else if (event is RefreshHistoryEvent) {
      yield* _mapFetch(false, true);
    }
  }

  Stream<HistoryState> _mapFetch([bool fetch = true, bool refresh = false]) async* {
    ApplicationsResponse response =
        fetch ? await repository.fetchHistory(fetch) : await repository.fetchHistory(refresh);

    if (refresh) {
      yield HistorySuccessRefreshState();
    }

    if (response.data.length == 0) {
      yield EmptyHistoryState();
    } else {
      yield HistorySuccessFetchState(response.data);
    }
  }
}
