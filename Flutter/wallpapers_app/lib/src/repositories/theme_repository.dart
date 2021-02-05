import 'package:flutter/material.dart';
import 'package:wallpapers/src/utils/palette.dart';

class ThemeRepository {
  static Palette _palette = Palette();

  Palette get palette => _palette;

  ThemeData theme = ThemeData.light().copyWith(
    primaryColor: _palette.primary,
    backgroundColor: Colors.white,
    accentColor: _palette.secondary,
    scaffoldBackgroundColor: _palette.background,
    splashColor: _palette.secondary.withOpacity(0.3),
    primaryColorLight: _palette.primary,
    primaryColorDark: _palette.primaryDark,
    iconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.secondary),
    primaryIconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.secondary),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
          brightness: Brightness.dark,
          color: Colors.white,
        ),
  );

  ThemeData appBarTheme = ThemeData.light().copyWith(
    primaryIconTheme: ThemeData.light().iconTheme.copyWith(color: _palette.secondary),
    scaffoldBackgroundColor: _palette.background,
    primaryColor: _palette.background,
    backgroundColor: _palette.background,
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
      color: _palette.background,
      elevation: 0.0,
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
      title: TextStyle(color: _palette.secondary),
      subtitle: TextStyle(color: _palette.secondary.withOpacity(0.5)),
      subhead: TextStyle(color: _palette.secondary.withOpacity(0.5)),
      caption: TextStyle(color: _palette.secondary.withOpacity(0.5))
    ),
    inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
      hintStyle: TextStyle(color: _palette.secondary.withOpacity(0.5)),
    ),
    accentColor: _palette.secondary,
    brightness: Brightness.dark
  );
}
