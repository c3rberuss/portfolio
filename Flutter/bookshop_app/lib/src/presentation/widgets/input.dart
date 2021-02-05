import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/colors/gf_color.dart';

class Input extends StatefulWidget {
  Input({
    Key key,
    this.onTextChange,
    this.radius = 4,
    this.textColor = "c0c0c0",
    this.backgroundColor = "ffffff",
    this.isPassword = false,
    this.placeholder = "",
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
    this.hint = "",
  }) : super(key: key);

  //States
  final Function onTextChange;
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
  final String hint;

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  double fontSize;
  Color labelColor;

  @override
  void initState() {
    super.initState();

    fontSize = 15;
    labelColor = GFColors.DARK.withOpacity(0.7);

    if (widget.controller != null && widget.onTextChange != null) {
      widget.controller.addListener(() {
        widget.onTextChange();
        setState(() {
          fontSize = getLabelSize();
        });
      });
    }

    if (widget.focusNode != null) {
      widget.focusNode.addListener(() {
        setState(() {
          fontSize = getLabelSize();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      inputFormatters: widget.formatter != null ? widget.formatter : null,
      keyboardType: widget.keyboardType,
      controller: widget.controller != null ? widget.controller : null,
      obscureText: widget.isPassword,
      textInputAction: widget.action,
      focusNode: widget.focusNode != null ? widget.focusNode : null,
      onSubmitted: (value) {
        if (widget.onAction != null) {
          widget.onAction();
        }
      },
      style: TextStyle(
        //color: HexColor(textColor),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        filled: true,
        fillColor: GFColors.WHITE,
        focusColor: GFColors.DANGER,
        hoverColor: GFColors.SUCCESS,
        labelText: widget.placeholder,
        labelStyle: TextStyle(
          //color: HexColor(textColor),
          fontSize: fontSize, //fontSize,
          color: labelColor,
        ),
        suffixIcon: _buildSuffix(),
        hintText: widget.hint,
        icon: widget.icon != null ? Icon(widget.icon) : null,
        hintStyle: TextStyle(
          //color: HexColor(textColor),
          fontSize: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: GFColors.PRIMARY,
          ),
        ),
      ),
    );
  }

  Widget _buildSuffix() {
    if (widget.controller == null || widget.controller.text.isEmpty || widget.showSuffix == false) {
      return Container(width: 0, height: 0);
    }

    return widget.isValid
        ? Tooltip(
            message: "Campo válido",
            child: Icon(
              FontAwesomeIcons.checkCircle,
              color: GFColors.SUCCESS,
            ),
          )
        : Tooltip(
            message: "Campo inválido",
            child: Icon(
              FontAwesomeIcons.timesCircle,
              color: GFColors.DANGER,
            ),
          );
  }

  double getLabelSize() {
    double size;

    if (widget.controller != null) {
      if (widget.controller.text.isEmpty) {
        if (widget.focusNode != null && widget.focusNode.hasFocus) {
          size = 18;
        } else if (widget.focusNode != null && !widget.focusNode.hasFocus) {
          size = 15;
        }
      } else {
        size = 18;
      }
    } else {
      if (widget.focusNode != null && widget.focusNode.hasFocus) {
        size = 18;
      } else if (widget.focusNode != null && !widget.focusNode.hasFocus) {
        size = 15;
      }
    }

    return size;
  }
}
