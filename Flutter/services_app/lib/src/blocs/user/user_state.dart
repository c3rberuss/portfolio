import 'package:equatable/equatable.dart';
import 'package:services/src/models/user_model.dart';

class UserState extends Equatable {
  final UserModel data;

  UserState(this.data);

  factory UserState.initial() {
    return UserState(
      UserModel(
        (u) => u
          ..email = ""
          ..name = ""
          ..phone = ""
          ..token = ""
          ..password = "",
      ),
    );
  }

  UserState copyWith(UserModel user) {
    return UserState(user);
  }

  @override
  List<Object> get props => [data];
}
