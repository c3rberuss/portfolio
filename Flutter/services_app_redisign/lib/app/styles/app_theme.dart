import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/app/styles/palette.dart';

class AppTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: Palette.success,
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}
