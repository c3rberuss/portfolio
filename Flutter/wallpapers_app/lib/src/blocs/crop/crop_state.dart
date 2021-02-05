import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CropState extends Equatable {
  final bool lock;
  final bool home;
  final bool both;
  final bool setting;
  final bool success;
  final bool error;

  CropState({
    @required this.home,
    @required this.both,
    @required this.lock,
    @required this.setting,
    @required this.error,
    @required this.success,
  });

  factory CropState.initial() {
    return CropState(
      home: true,
      lock: false,
      both: false,
      setting: false,
      success: false,
      error: false,
    );
  }

  CropState copyWith({
    bool lock,
    bool home,
    bool both,
    bool setting,
    bool success,
    bool error,
  }) {
    return CropState(
      lock: lock ?? this.lock,
      home: home ?? this.home,
      both: both ?? this.both,
      setting: setting ?? this.setting,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        home,
        lock,
        both,
        setting,
        success,
        error,
      ];
}
