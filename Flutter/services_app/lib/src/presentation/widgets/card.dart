import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({Key key, this.content, this.elevation = 12}) : super();

  //content
  final Widget content;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: elevation,
      color: Colors.white.withOpacity(0.90),
      child: content,
    );
  }
}
