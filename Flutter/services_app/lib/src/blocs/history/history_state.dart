import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:services/src/models/application_model.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class InitialHistoryState extends HistoryState {
  @override
  List<Object> get props => [];
}

class HistorySuccessFetchState extends HistoryState {
  final BuiltList<ApplicationModel> applications;

  HistorySuccessFetchState(this.applications);

  @override
  List<Object> get props => [applications];
}

class HistorySuccessRefreshState extends HistoryState {
  @override
  List<Object> get props => [];
}

class LoadingDataHistoryState extends HistoryState {
  @override
  List<Object> get props => [];
}

class EmptyHistoryState extends HistoryState {
  @override
  List<Object> get props => [];
}
