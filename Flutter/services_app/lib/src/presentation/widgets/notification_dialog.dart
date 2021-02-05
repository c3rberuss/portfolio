import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services/src/blocs/detail/bloc.dart';
import 'package:services/src/models/notification_data_model.dart';
import 'package:services/src/models/notification_model.dart';
import 'package:services/src/models/notification_origin.dart';
import 'package:services/src/models/notification_type.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationOrigin origin;
  final NotificationType type;
  final NotificationModel notification;
  final NotificationDataModel data;

  NotificationDialog({@required this.type, @required this.origin, this.notification, this.data});

  @override
  Widget build(BuildContext context) {
    Function callback;

    switch (type) {
      case NotificationType.serviceFinished:
        callback = () {
          print("Navigate to Payment");
          BlocProvider.of<DetailBloc>(context)
              .add(FetchApplicationEvent(int.parse(data.applicationId)));
          Navigator.pop(context);
          Navigator.pushNamed(context, "detail");
        };
        break;
      default:
        callback = () {
          Navigator.pop(context);
        };
        break;
    }

    if (origin == NotificationOrigin.onMessage) {
      return _buildDialog(title: notification.title, body: notification.body, onAccept: callback);
    }

    return _buildDialog(title: data.title, body: data.body, onAccept: callback);
  }

  Widget _buildDialog(
      {@required String title, @required String body, @required Function onAccept}) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        FlatButton(onPressed: onAccept, child: Text("OK")),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
