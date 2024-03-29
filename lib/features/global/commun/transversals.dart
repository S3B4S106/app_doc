import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<File> fileFromAssets(String path) async {
  var bytes = await rootBundle.load('assets/$path');
  final file = await File('${Directory.systemTemp.path}/$path')
      .writeAsBytes(bytes.buffer.asUint8List());

  return file;
}

String formatDate(DateTime date, {order = 1}) {
  var month = date.month > 9 ? date.month : "0${date.month}";
  var day = date.day > 9 ? date.day : "0${date.day}";
  if (order == 2) {
    return "${date.year}-$month-$day";
  } else {
    return "$day-$month-${date.year}";
  }
}

Color calculateAverageColor(List<Color> colors) {
  int red = 0;
  int green = 0;
  int blue = 0;

  for (Color color in colors) {
    red += color.red;
    green += color.green;
    blue += color.blue;
  }

  red = (red / colors.length).round();
  green = (green / colors.length).round();
  blue = (blue / colors.length).round();

  return Color.fromARGB(255, red, green, blue);
}

MaterialColor colour(Color darkmint1) {
  final int red = darkmint1.red;
  final int green = darkmint1.green;
  final int blue = darkmint1.blue;
  final int alpha = darkmint1.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };
  return MaterialColor(darkmint1.value, shades);
}
