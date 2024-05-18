import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';

Widget header() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [
        GlobalConfig.secundaryColorApp,
        GlobalConfig.primaryColorApp,
      ],
    )),
  );
}

Widget titleApp() {
  return Text(
      style: TextStyle(color: GlobalConfig.alternativeComplementaryColorApp),
      "P x P h o t o P r o");
}
