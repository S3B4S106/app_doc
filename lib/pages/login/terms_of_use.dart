import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(17.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Creando una cuenta, estas aceptando nuestros\n",
              style: TextStyle(color: Color.fromRGBO(221, 252, 212, 1)),
              children: [
                TextSpan(
                  text: "Terms of Service ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(221, 252, 212, 1)),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: "& "),
                TextSpan(
                  text: "Privacy Policy!",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(221, 252, 212, 1)),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                )
              ]),
        ));
  }
}
