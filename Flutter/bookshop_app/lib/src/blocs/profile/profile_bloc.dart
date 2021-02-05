import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookshop/src/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import './bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _repository;

  ProfileBloc(this._repository);

  @override
  ProfileState get initialState => ProfileState.initial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ClearSessionEvent) {
      yield ProfileState.initial();
    } else if (event is InitSessionEvent) {
      yield state.copyWith(user: event.user);
    } else if (event is UpdatePasswordEvent) {
      try {
        yield state.copyWith(sending: true);

        final response = await _repository.setPassword(event.currentPassword, event.newPassword);
        print("RESPONSE $response");

        yield state.copyWith(sending: false);

        if (response.code == 200) {
          yield state.copyWith(
            sending: false,
            error: false,
            success: true,
            message: "Se requiere que inicie sesión!",
          );
        } else {
          yield state.copyWith(
            sending: false,
            success: false,
            error: true,
            message: "Contraseña actual es incorrecta.",
          );
        }

        yield state.copyWith(error: false, success: false, message: "");
      } on DioError catch (error) {
        yield state.copyWith(sending: false);

        if (error.type == DioErrorType.DEFAULT) {
          yield state.copyWith(noInternet: true);
          yield state.copyWith(noInternet: false);
        } else {
          yield state.copyWith(
            sending: false,
            error: true,
            message: "Oops! Algo salió mal, intente nuevamenta más tarde.",
            success: false,
          );
        }
      }
    }
  }
}
