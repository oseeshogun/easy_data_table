import 'package:flutter/material.dart';

Color calculateTextColor(Color background) {
  return ThemeData.estimateBrightnessForColor(background) == Brightness.light
      ? Colors.black
      : Colors.white;
}
