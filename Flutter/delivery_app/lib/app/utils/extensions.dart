import 'package:flutter/material.dart';

extension Utils on BuildContext {
  ThemeData theme() {
    return Theme.of(this);
  }
}

extension Doubles on double {
  double interpolate(double x1, double y1, double x2, double y2) {
    if (this - x1 < 0) {
      return 0.0;
    }

    return (((this - x1) * (y2 - y1)) / (x2 - x1)) + y1;
  }
}
