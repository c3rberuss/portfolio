import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            width: screenWidth(context) * 0.2,
            height: screenWidth(context) * 0.2,
            padding: EdgeInsets.all(16),
            child: Theme(
              data: ThemeData(
                  accentColor: RepositoryProvider.of<ThemeRepository>(context).palette.primary),
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
