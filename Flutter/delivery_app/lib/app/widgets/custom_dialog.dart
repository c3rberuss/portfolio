import 'package:app/app/styles/palette.dart';
import 'package:app/app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

enum DialogType { Success, Error, Question, Info }

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key key,
    @required this.title,
    this.content = "",
    this.okButtonText = "Ok",
    this.onOkPress,
    this.onCancelPress,
    this.dialogType = DialogType.Success,
  }) : super();

  final String title;
  final String content;
  final String okButtonText;
  final DialogType dialogType;
  final List<Widget> buttons = List();

  //func's
  final Function onOkPress;
  final Function onCancelPress;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.white,
      insetAnimationCurve: Curves.elasticIn,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      color: Palette.dark.withOpacity(0.8),
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
                    child: CustomFillButton(
                      text: okButtonText,
                      buttonType: CustomButtonType.success,
                      height: 20,
                      onPressed: () {
                        if (onOkPress != null) onOkPress();
                        Get.back();
                      },
                    ),
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
        icon = LineIcons.check;
        color = Palette.success;
        break;
      case DialogType.Error:
        icon = LineIcons.times;
        color = Palette.danger;
        break;
      case DialogType.Question:
        icon = LineIcons.question;
        color = Palette.primary;
        break;
      case DialogType.Info:
        icon = LineIcons.exclamation;
        color = Palette.info;
        break;
    }

    return Icon(
      icon,
      color: color.withOpacity(0.5),
      size: 50,
    );
  }
}
