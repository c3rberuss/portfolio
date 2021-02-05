import 'package:flutter/material.dart';

class ClipLabel extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    path.moveTo(0, 0);
    path.lineTo(width*0.8, 0);
    path.lineTo(width, height*0.7);
    path.lineTo(width*0.9, height);
    path.lineTo(0, height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}