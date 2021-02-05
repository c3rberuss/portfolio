import 'package:app/app/styles/palette.dart';
import 'package:app/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

enum CustomButtonType { primary, secondary, success, danger, warning, info, light, dark, flat }

class _ButtonTypeTheme {
  final Color textColor;
  final Color background;
  final Color borderColor;
  final Color splashColor;
  final Color disabledColor;
  final Color highlightColor;
  final Color highlightTextColor;

  _ButtonTypeTheme({
    this.textColor,
    this.background,
    this.borderColor,
    this.splashColor,
    this.disabledColor,
    this.highlightColor,
    this.highlightTextColor,
  });
}

abstract class _CustomButton extends StatelessWidget {
  final bool fullWidth;
  final double maxWidth;
  final double minWidth;
  final double height;

  _CustomButton({
    this.fullWidth = false,
    this.maxWidth,
    this.minWidth,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    if (fullWidth) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minWidth: minWidth,
          minHeight: height,
          maxHeight: height,
        ),
        child: buildButton(),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: height,
      ),
      child: buildButton(),
    );
  }

  Widget buildButton();
}

abstract class _CustomIconButton extends StatelessWidget {
  final bool fullWidth;
  final double maxWidth;
  final double minWidth;

  _CustomIconButton({this.fullWidth = false, this.maxWidth, this.minWidth});

  @override
  Widget build(BuildContext context) {
    if (fullWidth) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minWidth: minWidth,
          minHeight: 45,
        ),
        child: buildFullWidthButton(),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 45,
      ),
      child: buildButton(),
    );
  }

  Widget buildFullWidthButton();
  Widget buildButton();
}

class FacebookButton extends _CustomIconButton {
  final String text;
  final VoidCallback onPressed;

  FacebookButton(
      {@required this.text,
      @required this.onPressed,
      bool fullWidth = false,
      double maxWidth,
      double minWidth})
      : super(
          fullWidth: fullWidth,
          maxWidth: maxWidth,
          minWidth: minWidth,
        );

  @override
  Widget buildButton() {
    return RaisedButton.icon(
      onPressed: onPressed,
      label: Text(this.text),
      icon: Icon(LineIcons.facebook),
      color: Palette.info,
      textColor: Palette.light,
      shape: Styles.shapeRounded(
        borderWidth: 0.5,
        borderColor: Palette.primaryDark,
      ),
    );
  }

  @override
  Widget buildFullWidthButton() {
    return RaisedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(LineIcons.facebook),
          Expanded(
            child: Text(
              this.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      color: Palette.info,
      textColor: Palette.light,
      shape: Styles.shapeRounded(
        borderWidth: 0.5,
        borderColor: Palette.primaryDark,
      ),
    );
  }
}

class GoogleButton extends _CustomIconButton {
  final String text;
  final VoidCallback onPressed;

  GoogleButton(
      {@required this.text,
      @required this.onPressed,
      bool fullWidth = false,
      double maxWidth,
      double minWidth})
      : super(
          fullWidth: fullWidth,
          maxWidth: maxWidth,
          minWidth: minWidth,
        );

  @override
  Widget buildButton() {
    return RaisedButton.icon(
      onPressed: onPressed,
      label: Text(this.text),
      icon: Icon(LineIcons.google),
      color: Palette.white,
      textColor: Palette.dark,
      shape: Styles.shapeRounded(
        borderWidth: 0.5,
        borderColor: Palette.dark,
      ),
    );
  }

  @override
  Widget buildFullWidthButton() {
    return RaisedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(LineIcons.google),
          Expanded(
            child: Text(
              this.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      color: Palette.white,
      textColor: Palette.dark,
      shape: Styles.shapeRounded(
        borderWidth: 0.5,
        borderColor: Palette.dark,
      ),
    );
  }
}

class CustomFillButton extends _CustomButton {
  final String text;
  final VoidCallback onPressed;
  final CustomButtonType buttonType;
  final TextStyle textStyle;
  final bool isEnabled;

  CustomFillButton({
    @required this.text,
    @required this.onPressed,
    this.buttonType = CustomButtonType.primary,
    this.textStyle,
    this.isEnabled = true,
    bool fullWidth = false,
    double maxWidth,
    double minWidth,
    double height = 45,
  }) : super(
          fullWidth: fullWidth,
          maxWidth: maxWidth,
          minWidth: minWidth,
          height: height,
        );

  @override
  Widget buildButton() {
    final theme = _selectFilledTheme(buttonType);

    return RaisedButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        text,
        style: textStyle != null
            ? textStyle.copyWith(color: theme.textColor)
            : TextStyle(
                fontSize: 16,
                color: theme.textColor,
              ),
      ),
      color: theme.background,
      splashColor: theme.splashColor,
      elevation: 2,
      highlightElevation: 4,
      highlightColor: theme.borderColor,
      shape: Styles.shapeRounded(
        borderColor: theme.borderColor,
      ),
    );
  }
}

class CustomOutlineButton extends _CustomButton {
  final String text;
  final VoidCallback onPressed;
  final CustomButtonType buttonType;
  final TextStyle textStyle;
  final bool isEnabled;

  CustomOutlineButton(
      {@required this.text,
      @required this.onPressed,
      this.buttonType = CustomButtonType.primary,
      this.textStyle,
      this.isEnabled = true,
      bool fullWidth = false,
      double maxWidth,
      double minWidth})
      : super(
          fullWidth: fullWidth,
          maxWidth: maxWidth,
          minWidth: minWidth,
        );

  @override
  Widget buildButton() {
    final theme = _selectOutlineTheme(buttonType);

    return OutlineButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        text,
        style: textStyle != null
            ? textStyle.copyWith(color: theme.textColor)
            : TextStyle(
                fontSize: 16,
                color: theme.textColor,
              ),
      ),
      splashColor: theme.splashColor,
      highlightColor: Palette.lightSecondary.withOpacity(0.1),
      highlightedBorderColor: theme.borderColor,
      borderSide: BorderSide(color: theme.borderColor),
      shape: Styles.shapeRounded(),
    );
  }
}

_ButtonTypeTheme _selectFilledTheme(CustomButtonType buttonType) {
  switch (buttonType) {
    case CustomButtonType.primary:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.primary,
        borderColor: Palette.primaryDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.secondary:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.grey,
        borderColor: Palette.greyDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.success:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.success,
        borderColor: Palette.success,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.danger:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.danger,
        borderColor: Palette.dangerDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.warning:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.warning,
        borderColor: Palette.warningDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.info:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.info,
        borderColor: Palette.infoDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.info:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.info,
        borderColor: Palette.infoDark,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    case CustomButtonType.dark:
      return _ButtonTypeTheme(
        textColor: Palette.white,
        background: Palette.dark,
        borderColor: Palette.darkLight,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
    default:
      return _ButtonTypeTheme(
        textColor: Palette.dark,
        background: Palette.light,
        borderColor: Palette.lightSecondary,
        splashColor: Palette.light.withOpacity(0.08),
      );
      break;
  }
}

_ButtonTypeTheme _selectOutlineTheme(CustomButtonType buttonType) {
  switch (buttonType) {
    case CustomButtonType.primary:
      return _ButtonTypeTheme(
        textColor: Palette.primary,
        borderColor: Palette.primary,
        splashColor: Palette.primary.withOpacity(0.08),
      );
      break;
    case CustomButtonType.secondary:
      return _ButtonTypeTheme(
        textColor: Palette.grey,
        borderColor: Palette.grey,
        splashColor: Palette.grey.withOpacity(0.08),
      );
      break;
    case CustomButtonType.success:
      return _ButtonTypeTheme(
        textColor: Palette.success,
        borderColor: Palette.success,
        splashColor: Palette.success.withOpacity(0.08),
      );
      break;
    case CustomButtonType.danger:
      return _ButtonTypeTheme(
        textColor: Palette.danger,
        borderColor: Palette.danger,
        splashColor: Palette.danger.withOpacity(0.08),
      );
      break;
    case CustomButtonType.warning:
      return _ButtonTypeTheme(
        textColor: Palette.warningDark,
        borderColor: Palette.warning,
        splashColor: Palette.warning.withOpacity(0.08),
      );
      break;
    case CustomButtonType.info:
      return _ButtonTypeTheme(
        textColor: Palette.info,
        borderColor: Palette.info,
        splashColor: Palette.info.withOpacity(0.08),
      );
      break;
    case CustomButtonType.dark:
      return _ButtonTypeTheme(
        textColor: Palette.dark,
        borderColor: Palette.dark,
        splashColor: Palette.dark.withOpacity(0.08),
      );
      break;
    default:
      return _ButtonTypeTheme(
        textColor: Palette.grey,
        borderColor: Palette.grey,
        splashColor: Palette.grey.withOpacity(0.08),
      );
      break;
  }
}
