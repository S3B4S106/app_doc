import 'dart:io';
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
