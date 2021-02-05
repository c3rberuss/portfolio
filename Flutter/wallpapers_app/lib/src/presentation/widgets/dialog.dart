import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpapers/src/utils/hexcolor.dart';

enum DialogType { Success, Error, Question, Info }

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key key,
    this.background = "ffffff",
    @required this.title,
    this.content = "",
    this.showCancelButton = false,
    this.okButtonText = "Ok",
    this.cancelButtonText = "Cancel",
    this.colorOkButtonText = "#4b7bec",
    this.colorCancelButtonText = "#eb3b5a",
    this.onOkPress,
    this.onCancelPress,
    this.dialogType = DialogType.Success,
  }) : super();

  final String background;
  final String title;
  final String content;
  final bool showCancelButton;
  final String okButtonText;
  final String cancelButtonText;
  final String colorOkButtonText;
  final String colorCancelButtonText;
  final DialogType dialogType;
  final List<Widget> buttons = List();

  //func's
  final Function onOkPress;
  final Function onCancelPress;

  @override
  Widget build(BuildContext context) {
    buttons.add(
      FlatButton(
        onPressed: () {
          if (onOkPress != null) onOkPress();
          Navigator.pop(context);
        },
        child: Text(
          okButtonText.toUpperCase(),
          style: TextStyle(color: HexColor(colorOkButtonText), fontSize: 18),
        ),
      ),
    );

    if (showCancelButton) {
      buttons.insert(
        0,
        FlatButton(
          onPressed: () {
            if (onCancelPress != null) onCancelPress();
            Navigator.pop(context);
          },
          child: Text(
            cancelButtonText.toUpperCase(),
            style: TextStyle(
              color: HexColor(colorCancelButtonText),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: HexColor(this.background),
      insetAnimationCurve: Curves.elasticIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                    child: selectIcon(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
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
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: buttons,
                  )
                ],
              ),
            ],
          )),
    );
  }

  Icon selectIcon() {
    IconData icon;
    Color color;

    switch (dialogType) {
      case DialogType.Success:
        icon = FontAwesomeIcons.checkCircle;
        color = HexColor("#20bf6b");
        break;
      case DialogType.Error:
        icon = FontAwesomeIcons.exclamationCircle;
        color = HexColor("#eb3b5a");
        break;
      case DialogType.Question:
        icon = FontAwesomeIcons.questionCircle;
        color = HexColor("#3867d6");
        break;
      case DialogType.Info:
        icon = FontAwesomeIcons.infoCircle;
        color = HexColor("#45aaf2");
        break;
    }

    return Icon(
      icon,
      color: color,
      size: 50,
    );
  }
}
