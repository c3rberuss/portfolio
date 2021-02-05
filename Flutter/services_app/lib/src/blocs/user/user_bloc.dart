import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:services/src/blocs/user/user_state.dart';

import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserState.initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is SaveUserEvent) {
      yield state.copyWith(event.user);
    }
  }
}
