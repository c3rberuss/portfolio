import 'package:bookshop/src/models/users/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class HeaderChangeHeight extends ProfileEvent {
  final double height;

  HeaderChangeHeight(this.height);

  @override
  List<Object> get props => [height];
}

class ClearSessionEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class InitSessionEvent extends ProfileEvent {
  final UserModel user;

  InitSessionEvent(this.user);

  @override
  List<Object> get props => [user];
}

class UpdatePasswordEvent extends ProfileEvent {
  final String newPassword;
  final String currentPassword;

  UpdatePasswordEvent(this.newPassword, this.currentPassword);

  @override
  List<Object> get props => [newPassword, currentPassword];
}
