import 'package:flutter/material.dart';
import 'package:wallpapers/src/presentation/widgets/dialog.dart';

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

Future<void> showSuccess(BuildContext context, String message, [String title = "Éxito"]) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return CustomDialog(
        title: title,
        content: message,
        dialogType: DialogType.Success,
      );
    },
  );
}

Future<void> showError(BuildContext context, String error, [String title = "Error"]) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return CustomDialog(
        title: title,
        content: error,
        dialogType: DialogType.Error,
      );
    },
  );
}

Future<void> showMessage(BuildContext context, String message,
    [String title = "Message", DialogType type = DialogType.Info]) async {
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

