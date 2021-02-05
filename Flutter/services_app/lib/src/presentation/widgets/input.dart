import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:services/src/utils/hexcolor.dart';

class Input extends StatelessWidget {
  Input({
    Key key,
    this.onTextChange,
    this.radius = 8,
    this.textColor = "c0c0c0",
    this.backgroundColor = "ffffff",
    this.isPassword = false,
    this.placeholder = "Placeholder",
    this.icon,
    this.value = "",
    this.validator,
    this.required = true,
    this.name = "",
    this.controller,
    this.keyboardType = TextInputType.text,
    this.formatter,
    this.focusNode,
    this.action = TextInputAction.next,
    this.onAction,
    this.isValid = false,
    this.showSuffix = false,
  }) : super(key: key);

  //States
  final Function(String) onTextChange;
  final TextEditingController controller;
  final double radius;
  final String textColor;
  final String backgroundColor;
  final bool isPassword;
  final String placeholder;
  final IconData icon;
  final String value;
  final validator;
  final bool required;
  final String name;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatter;
  final FocusNode focusNode;
  final TextInputAction action;
  final Function onAction;
  final bool isValid;
  final bool showSuffix;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor(backgroundColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: TextField(
          inputFormatters: formatter != null ? formatter : null,
          keyboardType: keyboardType,
          controller: controller != null ? controller : null,
          obscureText: isPassword,
          onChanged: onTextChange,
          textInputAction: action,
          focusNode: focusNode != null ? focusNode : null,
          onSubmitted: (value) {
            if (onAction != null) {
              onAction();
            }
          },
          style: TextStyle(
            color: HexColor(textColor),
            fontSize: 20,
          ),
          decoration: InputDecoration(
            suffixIcon: _buildSuffix(),
            hintText: placeholder,
            icon: icon != null ? Icon(icon) : null,
            hintStyle: TextStyle(
              color: HexColor(textColor),
              fontSize: 20,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 0.0,
                style: BorderStyle.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuffix() {
    if (controller == null || controller.text.isEmpty || showSuffix == false) {
      return Container(width: 0, height: 0);
    }

    return isValid
        ? Tooltip(message: "Valid field", child: Icon(FontAwesomeIcons.checkCircle))
        : Tooltip(message: "Invalid field", child: Icon(FontAwesomeIcons.timesCircle));
  }
}
