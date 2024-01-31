import 'dart:io';
import 'package:flutter/services.dart';

Future<File> fileFromAssets(String path) async {
  var bytes = await rootBundle.load('assets/$path');
  final file = await File('${Directory.systemTemp.path}/$path')
      .writeAsBytes(bytes.buffer.asUint8List());

  return file;
}
