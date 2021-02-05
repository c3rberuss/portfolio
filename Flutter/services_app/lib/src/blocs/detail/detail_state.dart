import 'package:equatable/equatable.dart';
import 'package:services/src/models/application_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();
}

class InitialDetailState extends DetailState {
  @override
  List<Object> get props => [];
}

class FetchingDataState extends DetailState {
  @override
  List<Object> get props => [];
}

class SendingPaymentState extends DetailState {
  @override
  List<Object> get props => [];
}

class PaymentSendState extends DetailState {
  final int applicationId;

  PaymentSendState(this.applicationId);

  @override
  List<Object> get props => [applicationId];
}

class PaymentErrorState extends DetailState {
  @override
  List<Object> get props => [];
}

class FetchingDataSuccessState extends DetailState {
  final ApplicationModel application;

  FetchingDataSuccessState(this.application);

  @override
  List<Object> get props => [application];
}
