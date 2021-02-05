import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:services/app/styles/palette.dart';

class CustomFilledButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;

  CustomFilledButton({this.onPressed, this.text = "Click me", this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      onPressed: this.onPressed,
      color: this.backgroundColor ?? Palette.success,
      child: Text(
        this.text.toUpperCase(),
        style: GoogleFonts.poppins(color: Palette.white),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  CustomOutlineButton({this.onPressed, this.text = "Click me"});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: this.onPressed,
      color: Palette.primary,
      child: Text(
        this.text.toUpperCase(),
        style: GoogleFonts.poppins(color: Palette.primary),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomFlatButton({this.text = "FLAT BUTTON", this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Palette.grey,
      textColor: Palette.light,
      child: Text(text),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
