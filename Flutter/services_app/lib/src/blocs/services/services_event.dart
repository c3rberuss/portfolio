import 'package:equatable/equatable.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();
}

class FetchServicesEvent extends ServicesEvent {
  final int categoryId;

  FetchServicesEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class RefreshServicesEvent extends ServicesEvent {
  final int categoryId;

  RefreshServicesEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
