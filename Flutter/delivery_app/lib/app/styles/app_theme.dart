import 'package:app/app/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: Palette.dark,
    textTheme: GoogleFonts.khulaTextTheme(),
    cursorColor: Palette.dark,
    scaffoldBackgroundColor: Palette.white,
    splashColor: Palette.dark.withOpacity(0.3),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    accentColor: Palette.success,
  );
}
