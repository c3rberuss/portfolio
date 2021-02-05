import 'package:equatable/equatable.dart';
import 'package:services/src/models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SaveUserEvent extends UserEvent {
  final UserModel user;

  SaveUserEvent(this.user);

  @override
  List<Object> get props => [user];
}
