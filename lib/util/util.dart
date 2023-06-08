import 'package:flutter/material.dart';

mixin GutenUiMixin {
  static Color getRandomColor(int idx) {
    List<Color> colors = [
      Colors.blueAccent,
      Colors.blue,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.pinkAccent,
      Colors.orange,
    ];
    return colors[idx % colors.length];
  }
}