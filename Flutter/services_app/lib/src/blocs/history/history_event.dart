import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class FetchHistoryEvent extends HistoryEvent {
  @override
  List<Object> get props => [];
}

class RefreshHistoryEvent extends HistoryEvent {
  @override
  List<Object> get props => [];
}



