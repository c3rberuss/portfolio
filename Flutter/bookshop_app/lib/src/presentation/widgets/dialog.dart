import 'package:bookshop/src/repositories/theme_repository.dart';
import 'package:bookshop/src/utils/functions.dart';
import 'package:bookshop/src/utils/hexcolor.dart';
import 'package:bookshop/src/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

enum DialogType { Success, Error, Question, Info, Tracking, NoInternet }

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key key,
    this.background = "ffffff",
    @required this.title,
    this.content = "",
    this.okButtonText = "Ok",
    this.colorOkButtonText,
    this.onOkPress,
    this.onCancelPress,
    this.dialogType = DialogType.Success,
  }) : super();

  final String background;
  final String title;
  final String content;
  final String okButtonText;
  final String colorOkButtonText;
  final DialogType dialogType;
  final List<Widget> buttons = List();

  //func's
  final Function onOkPress;
  final Function onCancelPress;

  @override
  Widget build(BuildContext context) {
    final _theme = RepositoryProvider.of<ThemeRepository>(context);

    return Dialog(
      backgroundColor: HexColor(this.background),
      insetAnimationCurve: Curves.elasticIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
          padding: EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 8),
          child: Wrap(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: selectIcon(_theme.palette),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _theme.palette.dark.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GFButton(
                      shape: GFButtonShape.standard,
                      type: GFButtonType.solid,
                      onPressed: () {
                        if (onOkPress != null) onOkPress();
                        pop(context);
                      },
                      text: okButtonText,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Icon selectIcon(Palette palette) {
    IconData icon;
    Color color;

    switch (dialogType) {
      case DialogType.Success:
        icon = FontAwesomeIcons.solidCheckCircle;
        color = palette.success;
        break;
      case DialogType.Error:
        icon = FontAwesomeIcons.solidTimesCircle;
        color = palette.danger;
        break;
      case DialogType.Question:
        icon = FontAwesomeIcons.solidQuestionCircle;
        color = palette.primary;
        break;
      case DialogType.Info:
        icon = FontAwesomeIcons.exclamationCircle;
        color = palette.info;
        break;
      case DialogType.Tracking:
        icon = FontAwesomeIcons.mapMarkedAlt;
        color = palette.primary;
        break;
      case DialogType.NoInternet:
        icon = FontAwesomeIcons.exclamationCircle;
        color = palette.warning;
        break;
    }

    return Icon(
      icon,
      color: color.withOpacity(0.5),
      size: 50,
    );
  }
}
