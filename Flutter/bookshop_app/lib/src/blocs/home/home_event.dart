import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class ChangeScreenEvent extends HomeEvent {
  final int screenIndex;

  ChangeScreenEvent(this.screenIndex);

  @override
  List<Object> get props => [screenIndex];
}

class ResetStateEvent extends HomeEvent{
  @override
  List<Object> get props => [];
}
