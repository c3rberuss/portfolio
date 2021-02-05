import 'package:app/app/styles/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class OrderItemView extends StatelessWidget {
  final _style = TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(8),
      decoration: Styles.boxDecoration(),
      child: Row(
        children: [
          Icon(LineIcons.clock_o, size: 30),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("N° orden", style: _style),
                    Text("24/11/2020", style: _style),
                  ],
                ),
                Text("Nombre del negocio", style: _style),
                Text(
                  "Total: \$4.75",
                  style: _style.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
