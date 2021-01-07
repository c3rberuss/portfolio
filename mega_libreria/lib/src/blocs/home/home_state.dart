import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class HomeState extends Equatable {
  final int screenIndex;
  final bool clearSession;

  HomeState({@required this.screenIndex, @required this.clearSession});

  factory HomeState.initial() {
    return HomeState(
      screenIndex: 0,
      clearSession: false,
    );
  }

  HomeState copyWith({int screenIndex, bool clear}) {
    return HomeState(
      screenIndex: screenIndex ?? this.screenIndex,
      clearSession: clear ?? this.clearSession,
    );
  }

  @override
  List<Object> get props => [screenIndex, clearSession];
}
