import 'package:bookshop/src/utils/palette.dart';
import 'package:flutter/material.dart';

class Styles {
  static InputDecoration inputDecorator(Palette colors,
      {String label = "",
      double fontSize = 15,
      Color labelColor,
      String placeholder,
      IconData prefix}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      filled: true,
      fillColor: colors.white,
      focusColor: colors.danger,
      hoverColor: colors.success,
      labelText: label,
      prefixIcon: prefix != null ? Icon(prefix) : null,
      labelStyle: TextStyle(
        //color: HexColor(textColor),
        fontSize: fontSize, //fontSize,
        color: labelColor ?? colors.dark.withOpacity(0.7),
      ),
      hintText: placeholder,
      hintStyle: TextStyle(
        //color: HexColor(textColor),
        fontSize: 15,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          style: BorderStyle.solid,
          color: colors.primary,
        ),
      ),
    );
  }

  static SnackBar snackBar(String text, Palette palette,
      [Icon icon, Color background, TextStyle textStyle]) {
    return SnackBar(
      backgroundColor: background ?? palette.primary,
      content: Row(
        children: <Widget>[
          icon ?? Icon(Icons.check),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
              style: textStyle ??
                  TextStyle(
                    color: palette.white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
