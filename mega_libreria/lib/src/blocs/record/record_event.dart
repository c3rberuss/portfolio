import 'package:equatable/equatable.dart';

abstract class RecordEvent extends Equatable {
  const RecordEvent();
}

class FetchRecordEvent extends RecordEvent {
  final int orderId;

  FetchRecordEvent(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class RefreshRecordEvent extends RecordEvent {
  @override
  List<Object> get props => [];
}

class ClearStateEvent extends RecordEvent {
  @override
  List<Object> get props => [];
}
