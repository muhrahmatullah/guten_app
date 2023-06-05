import 'dart:math';

import 'package:flutter/material.dart';

mixin GutenUiMixin {
  static Color getRandomColor() {
    List<Color> colors = [
      Colors.blueAccent,
      Colors.blue,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.pinkAccent,
      Colors.orange,
    ];
    final randomize = Random();
    return colors[randomize.nextInt(5)];
  }
}