library globals;

import 'dart:ui';

import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:flutter/material.dart';

class GlobalConfig {
  static FlutterView screen = PlatformDispatcher.instance.views.first;
  static Color backgroundColor = calculateAverageColor(const LinearGradient(
    colors: [Color.fromRGBO(7, 54, 69, 1), Color.fromRGBO(13, 13, 13, 1)],
  ).colors);
  static Color seedColor = const Color.fromARGB(255, 32, 83, 102);
  static Color borderColor = const Color.fromRGBO(59, 122, 137, 1);
  static Color backgroundButtonColor = const Color.fromRGBO(18, 62, 89, 1);
  static Color textColor = const Color.fromRGBO(122, 188, 176, 1);
  static Color primaryColorApp = const Color.fromRGBO(35, 93, 113, 1);

  static ColorScheme colorApp = ColorScheme.fromSeed(
      brightness: PlatformDispatcher.instance.platformBrightness,
      seedColor: seedColor,
      background: backgroundColor);

  static double height = screen.physicalSize.height / screen.devicePixelRatio;
  static double width = screen.physicalSize.width / screen.devicePixelRatio;

  static double heightPercentage(double percentage) {
    percentage = percentage > 1 ? percentage / 100 : percentage;
    return height * percentage;
  }

  static double widthPercentage(double percentage) {
    percentage = percentage > 1 ? percentage / 100 : percentage;
    return width * percentage;
  }
}
