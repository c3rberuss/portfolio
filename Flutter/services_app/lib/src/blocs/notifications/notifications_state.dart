import 'package:equatable/equatable.dart';
import 'package:services/src/models/notification_origin.dart';
import 'package:services/src/models/notification_response.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class InitialNotificationsState extends NotificationsState {
  @override
  List<Object> get props => [];
}

class ShowNotification extends NotificationsState {
  final NotificationOrigin origin;
  final NotificationResponse body;

  ShowNotification(this.origin, this.body);

  @override
  List<Object> get props => [this.origin, this.body];
}
