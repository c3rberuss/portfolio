import 'package:bookshop/src/models/users/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ProfileState extends Equatable {
  final UserModel user;
  final bool success;
  final bool error;
  final bool sendingData;
  final String message;
  final bool noInternet;

  ProfileState({
    @required this.success,
    @required this.user,
    @required this.message,
    @required this.sendingData,
    @required this.error,
    @required this.noInternet,
  });

  factory ProfileState.initial() {
    return ProfileState(
      success: false,
      user: UserModel(
        (u) => u
          ..email = ""
          ..name = ""
          ..token = ""
          ..password = "",
      ),
      message: "",
      sendingData: false,
      error: false,
      noInternet: false,
    );
  }

  ProfileState copyWith({
    bool success,
    UserModel user,
    bool sending,
    String message,
    bool error,
    bool noInternet,
  }) {
    return ProfileState(
      success: success ?? this.success,
      user: user ?? this.user,
      message: message ?? this.message,
      sendingData: sending ?? this.sendingData,
      error: error ?? this.error,
      noInternet: noInternet ?? this.noInternet,
    );
  }

  @override
  List<Object> get props => [
        success,
        user,
        sendingData,
        message,
        error,
        noInternet,
      ];
}
