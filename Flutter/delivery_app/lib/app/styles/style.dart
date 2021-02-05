import 'package:app/app/styles/palette.dart';
import 'package:flutter/material.dart';

class Styles {
  static ShapeBorder shapeRounded(
      {double radius = 10,
      Color borderColor,
      double borderWidth = 1.0,
      BorderStyle style = BorderStyle.solid}) {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(
        color: borderColor ?? Colors.black,
        width: borderWidth,
        style: style,
      ),
    );
  }

  static Border border({Color color}) {
    final _side = BorderSide(color: color ?? Colors.black, width: 0.75);

    return Border(
      left: _side,
      right: _side,
      bottom: _side,
      top: _side,
    );
  }

  static BoxDecoration boxDecoration({
    Color borderColor,
    double borderRadius,
    Color background,
    Color shadow,
  }) {
    return BoxDecoration(
      color: background ?? Colors.white,
      border: border(color: Palette.lightSecondary),
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          color: shadow != null ? shadow.withOpacity(0.15) : Palette.grey.withOpacity(0.15),
        ),
      ],
    );
  }
}
