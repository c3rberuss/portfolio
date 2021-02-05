import 'dart:async';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  @override
  NotificationsState get initialState => InitialNotificationsState();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is NotificationReceived) {
      yield ShowNotification(event.origin, event.notification);
      yield InitialNotificationsState();
    }
  }
}
