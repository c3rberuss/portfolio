import 'package:flutter/material.dart';
import 'package:services/src/utils/hexcolor.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key key,
      @required this.callback,
      this.text = "Button",
      this.background = "4b7bec",
      this.textColor = "ffffff",
      this.disabled = false,
      this.width = 100})
      : super();

  //Callbacks
  final Function callback;

  //vars
  final String text;
  final String background;
  final String textColor;
  final bool disabled;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: disabled ? null : callback,
      color: HexColor(background),
      disabledColor: HexColor("#4baeec"),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: HexColor(textColor),
          fontSize: 15,
        ),
      ),
      height: 45,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
