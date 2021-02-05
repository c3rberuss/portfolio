import 'package:app/app/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SearchBar extends StatelessWidget {
  final VoidCallback onTap;
  final String hint;

  SearchBar({@required this.onTap, this.hint = "Busca lo que quieras"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 70,
      decoration: BoxDecoration(
        color: Palette.dark.withOpacity(0.7),
        boxShadow: [
          BoxShadow(
            color: Palette.dark.withOpacity(0.3),
            offset: Offset(0, -5),
            blurRadius: 10,
          )
        ],
      ),
      padding: EdgeInsets.all(16),
      child: TextField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          prefixIcon: Icon(LineIcons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Palette.light,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: hint,
        ),
        cursorColor: Palette.grey,
      ),
    );
  }
}
