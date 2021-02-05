import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/app/styles/palette.dart';

class ProgressDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => ProgressDialog(
            key: key,
          )).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  ProgressDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: Get.width * 0.2,
            height: Get.width * 0.2,
            padding: EdgeInsets.all(16),
            child: Theme(
              data: ThemeData(accentColor: Palette.primary),
              child: CircularProgressIndicator(
                strokeWidth: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
