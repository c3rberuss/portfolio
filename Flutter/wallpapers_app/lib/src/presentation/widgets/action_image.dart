import 'package:flutter/material.dart';

class ActionImage extends StatelessWidget {

  final IconData icon;
  final Function onTap;
  final String text;
  final Color color;


  ActionImage({@required this.icon, @required this.onTap, @required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(icon: Icon(icon, color: color, size: 35,), onPressed: onTap),
        Text(text, style: TextStyle(color: color, fontSize: 18)),
      ],
    );
  }
}
