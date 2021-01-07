import 'package:flutter/material.dart';
import 'package:megalibreria/src/presentation/widgets/confirmation_dialog.dart';
import 'package:megalibreria/src/presentation/widgets/dialog.dart';

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
        okButtonText: "Aceptar",
      );
    },
  );
}
/*
Future<void> showNotification(BuildContext context, NotificationDataModel data) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return CustomDialog(
        title: data.company.toUpperCase(),
        content: data.title+"\n\n"+data.body,
        dialogType: DialogType.Tracking,
        okButtonText: "Ver",
        cancelButtonText: "Cerrar",
        showCancelButton: true,
        onOkPress: (){
          Navigator.pop(context);
          Navigator.pushNamed(context, 'user_order_detail/${data.orderId}/true');
        },
      );
    },
  );
}*/

Future<bool> showConfirmation(BuildContext context, String title, String message,
    {String ok = "Aceptar", String cancel = "Cancel"}) async {
  final data = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return ConfirmationDialog(
        title: title,
        content: message,
        okButtonText: ok,
        cancelButtonText: cancel,
      );
    },
  );

  return Future.value(data);
}

/*Future<double> rateOrder(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return RatingOrderDialog();
    },
  );
}*/


Future<void> noInternetConnection(BuildContext context, [Function onPress]) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return CustomDialog(
        title: "Sin conexión a internet",
        content: "Para usar esta aplicación es necesario tener una conexión a internet",
        dialogType: DialogType.NoInternet,
        onOkPress: onPress ?? (){},
      );
    },
  );
}