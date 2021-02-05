import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();
}

class FetchApplicationEvent extends DetailEvent {
  final int applicationId;

  FetchApplicationEvent(this.applicationId);

  @override
  List<Object> get props => [applicationId];
}

class PayServiceEvent extends DetailEvent {
  final int applicationId;
  final double amount;
  final BuildContext context;

  PayServiceEvent(this.applicationId, this.amount, this.context);

  @override
  List<Object> get props => [amount, this.applicationId, this.context];
}