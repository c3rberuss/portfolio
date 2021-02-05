import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PainterCenter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
/*    final path1 = Path();
    path1.fillType = PathFillType.nonZero;
    path1.moveTo(size.width/2, 0);
    path1.lineTo(size.width/2, size.height);

    final path2 = Path();
    path2.moveTo(0, size.height/2);
    path2.lineTo(size.width, size.height/2);

    path1.close();
    //path2.close();

    canvas.drawPath(path1, Paint()..color=Colors.black..strokeWidth=5);*/
    //canvas.drawPath(path2, Paint()..color=Colors.black..strokeWidth=1);

    canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1);

    canvas.drawLine(
        Offset(size.width/2, 0),
        Offset(size.width/2, size.height),
        Paint()
          ..color = Colors.black
          ..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
