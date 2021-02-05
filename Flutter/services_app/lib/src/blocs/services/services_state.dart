import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:services/src/models/service_model.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
}

class LoadingServicesState extends ServicesState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ServicesObtainedState extends ServicesState {
  final BuiltList<ServiceModel> services;

  ServicesObtainedState(this.services);

  @override
  List<Object> get props => [services];
}

class EmptyServicesState extends ServicesState {
  final String message;

  EmptyServicesState(this.message);

  @override
  List<Object> get props => [message];
}

class RefreshServicesCompleted extends ServicesState {
  @override
  List<Object> get props => [];
}
