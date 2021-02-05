import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/src/utils/hexcolor.dart';

class TextArea extends StatelessWidget {
  TextArea({
    Key key,
    this.onTextChange,
    this.radius = 8,
    this.textColor = "c0c0c0",
    this.backgroundColor = "ffffff",
    this.placeholder = "Placeholder",
    this.icon,
    this.value = "",
    this.validator,
    this.required = true,
    this.name = "",
    this.controller,
    this.maxLines = 8,
    this.focusNode,
  }) : super(key: key);

  //States
  final Function(String) onTextChange;
  final TextEditingController controller;
  final double radius;
  final String textColor;
  final String backgroundColor;
  final String placeholder;
  final IconData icon;
  final String value;
  final validator;
  final bool required;
  final String name;
  final int maxLines;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: HexColor(backgroundColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: TextField(
          focusNode: focusNode,
          maxLines: maxLines,
          controller: controller,
          onChanged: onTextChange,
          style: TextStyle(
            color: HexColor(textColor),
            fontSize: 20,
          ),
          decoration: InputDecoration(
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
}
