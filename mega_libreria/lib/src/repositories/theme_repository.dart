import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:megalibreria/src/utils/palette.dart';

class ThemeRepository {
  static Palette _palette = Palette();

  Palette get palette => _palette;

  ThemeData theme = ThemeData.light().copyWith(
    primaryColor: _palette.primary,
    backgroundColor: GFColors.WHITE,
    accentColor: _palette.light,
    scaffoldBackgroundColor: _palette.white,
    splashColor: _palette.primary.withOpacity(0.3),
    primaryColorLight: _palette.primary,
    focusColor: _palette.primary,
    primaryColorDark: _palette.primaryDark,
    hintColor: GFColors.PRIMARY,
    errorColor: GFColors.DANGER,
    iconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.primary),
    primaryIconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.primary),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          brightness: Brightness.dark,
          color: GFColors.WHITE,
        ),
  );

  ThemeData appBarTheme = ThemeData.light().copyWith(
    primaryIconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.primary),
    scaffoldBackgroundColor: _palette.white,
    primaryColor: _palette.white,
    backgroundColor: _palette.white,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          color: _palette.white,
          elevation: 0.0,
        ),
    textTheme: ThemeData.light().textTheme.copyWith(
          headline6:  TextStyle(color: _palette.primary.withOpacity(0.5)),
          subtitle1:  TextStyle(color: _palette.primary.withOpacity(0.5)),
          subtitle2:  TextStyle(color: _palette.primary.withOpacity(0.5)),
          caption: TextStyle(color: _palette.primary.withOpacity(0.5)),
        ),
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
          hintStyle: TextStyle(color: _palette.primary.withOpacity(0.5)),
        ),
    accentColor: _palette.primary,
    brightness: Brightness.dark,
  );
}
