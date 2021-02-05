import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/app/styles/palette.dart';
import 'package:services/app/utils/constants.dart';
import 'package:services/app/utils/extensions.dart';

class AppLogo extends StatelessWidget {
  final Color textColor;
  final double widthFactor;

  AppLogo({this.textColor, this.widthFactor = 0.35});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.biggest.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: constraints.biggest.width * this.widthFactor,
                child: Image.asset(
                  "assets/icons/logo.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              AutoSizeText(
                APP_NAME,
                style: GoogleFonts.poppins(
                  textStyle: context.theme().textTheme.headline3,
                  color: textColor ?? Palette.light,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
