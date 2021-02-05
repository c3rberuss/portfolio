import 'package:equatable/equatable.dart';
import 'package:services/src/models/notification_origin.dart';
import 'package:services/src/models/notification_response.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationReceived extends NotificationsEvent {
  final NotificationOrigin origin;
  final NotificationResponse notification;

  NotificationReceived(this.origin, this.notification);

  @override
  List<Object> get props => [origin, notification];
}
