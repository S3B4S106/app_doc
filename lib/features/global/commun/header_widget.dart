import 'package:flutter/material.dart';

Widget header() {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
      colors: [
        Color.fromRGBO(35, 93, 113, 1),
        Color.fromRGBO(124, 187, 176, 1)
      ],
    )),
  );
}

Widget titleApp() {
  return const Text("P x P h o t o P r o");
}
