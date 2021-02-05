import 'package:flutter/material.dart';
import 'package:services/src/models/notification_response.dart';
import 'package:services/src/presentation/widgets/dialog.dart';

pop(context) {
  Future.delayed(Duration.zero, () {
    Navigator.of(context).pop();
  });
}

void fieldFocusChange(BuildContext context, FocusNode currentFocus, [FocusNode nextFocus]) {
  currentFocus.unfocus();
  if (nextFocus != null) {
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

Future<dynamic> onBackgroundMessageHandler(Map<String, dynamic> message) {
  final data = NotificationResponse.fromJson(message);

  print(data);

  // Or do other work.
  return null;
}

Future<void> showMessage(BuildContext context, String message,
    [DialogType type = DialogType.Success, String title = "Application"]) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return CustomDialog(
        title: title,
        content: message,
        dialogType: type,
      );
    },
  );
}
