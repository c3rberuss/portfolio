import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/notifications/notifications_bloc.dart';
import 'package:services/src/blocs/notifications/notifications_event.dart';
import 'package:services/src/models/notification_origin.dart';
import 'package:services/src/models/notification_response.dart';
import 'package:services/src/utils/functions.dart';
import 'package:vibration/vibration.dart';

class Notifications {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  // ignore: close_sinks
  NotificationsBloc _bloc;

  void setupNotifications(BuildContext context) {
    if (_bloc == null) {
      _bloc = BlocProvider.of<NotificationsBloc>(context);
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        vibrate();

        _bloc.add(
          NotificationReceived(
            NotificationOrigin.onMessage,
            NotificationResponse.fromJson(message),
          ),
        );

        print("onMessage: ${NotificationResponse.fromJson(message)}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        try {
          _bloc.add(
            NotificationReceived(
              NotificationOrigin.onLaunch,
              NotificationResponse.fromJson(message),
            ),
          );

          print("onLaunch: ${NotificationResponse.fromJson(message)}");
        } catch (e) {
          print(e);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        try {
          _bloc.add(
            NotificationReceived(
              NotificationOrigin.onResume,
              NotificationResponse.fromJson(message),
            ),
          );
          print("onResume: ${NotificationResponse.fromJson(message)}");
        } catch (e) {
          print(e);
        }
      },
    );
  }

  Future<void> vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }
}
