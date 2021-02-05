import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:services/app/styles/palette.dart';

class Input extends StatefulWidget {
  final Widget suffixIcon;
  final Icon prefixIcon;
  final Icon showPasswordIcon;
  final Icon hidePasswordIcon;
  final Icon clearIcon;
  final bool isPassword;
  final bool showClear;
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputAction action;
  final VoidCallback onAction;
  final FocusNode focus;
  final FocusNode nextFocus;
  final TextInputType keyboardType;
  final bool enabled;
  final List<String Function(String)> validators;
  final Color labelColor;

  Input(
      {this.suffixIcon,
      this.prefixIcon,
      this.isPassword = false,
      @required this.controller,
      this.label = "",
      this.hint = "",
      this.showClear = true,
      this.clearIcon = const Icon(LineIcons.times),
      this.showPasswordIcon = const Icon(LineIcons.eye),
      this.hidePasswordIcon = const Icon(LineIcons.eye_slash),
      this.action = TextInputAction.done,
      this.focus,
      this.nextFocus,
      this.onAction,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.validators = const [],
      this.labelColor})
      : assert((isPassword && !showClear) || (!isPassword && showClear));

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPassword;
  bool showClear;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    this.isPassword = widget.isPassword;
    showClear = widget.controller.text.isNotEmpty;

    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty != showClear) {
        if (mounted) {
          setState(() {
            showClear = widget.controller.text.isNotEmpty;
          });
        }
      }
    });

    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty) {
        _validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.label.isNotEmpty
              ? Text(
                  widget.label,
                  style: TextStyle(color: widget.labelColor ?? Colors.black),
                )
              : SizedBox.shrink(),
          Container(
            margin: EdgeInsets.only(
              top: widget.label.isNotEmpty ? 4 : 0,
              bottom: errorMessage != null ? 4 : 0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 5),
                  color: Palette.dark.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 0.1,
                )
              ],
            ),
            child: TextField(
              enabled: widget.enabled,
              controller: widget.controller,
              obscureText: this.isPassword && widget.isPassword,
              textInputAction: widget.action,
              focusNode: widget.focus,
              onSubmitted: (value) {
                if (widget.onAction != null) widget.onAction();

                if (widget.nextFocus != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocus);
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                fillColor: Palette.light,
                filled: true,
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                prefixIcon: widget.prefixIcon,
                suffixIcon: _buildSuffixIcon(),
                hintText: widget.hint,
              ),
            ),
          ),
          errorMessage != null ? Text(errorMessage, maxLines: 1) : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildSuffixIcon() {
    if (widget.isPassword && !widget.showClear) {
      return _buildPasswordIcon();
    } else if (!widget.isPassword && widget.showClear) {
      return _buildClearIcon();
    }

    return null;
  }

  Widget _buildPasswordIcon() {
    if (this.isPassword) {
      return IconButton(
        icon: widget.showPasswordIcon,
        onPressed: () {
          if (mounted) {
            setState(() {
              isPassword = !isPassword;
            });
          }
        },
      );
    }

    return IconButton(
      icon: widget.hidePasswordIcon,
      onPressed: () {
        if (mounted) {
          setState(() {
            isPassword = !isPassword;
          });
        }
      },
    );
  }

  Widget _buildClearIcon() {
    if (widget.showClear && showClear) {
      return IconButton(
        icon: widget.clearIcon,
        onPressed: () {
          widget.controller.clear();
          if (mounted) {
            setState(() {
              errorMessage = null;
            });
          }
        },
      );
    }

    return null;
  }

  void _validate() {
    for (String Function(String) validator in widget.validators) {
      final String error = validator(widget.controller.text);

      if (error != null) {
        if (mounted) {
          setState(() {
            errorMessage = error;
          });
        }
        break;
      } else {
        if (mounted) {
          setState(() {
            errorMessage = null;
          });
        }
      }
    }
  }
}
