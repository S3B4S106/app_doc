import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  FirebaseAuthService _authService = FirebaseAuthService();
  var user;
  dynamic myModel;
  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    myModel = parameters['model'];
    user = myModel.doctor;
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          flexibleSpace: header(),
          title: titleApp(),
        ),
        body: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                  ),
                  Text(formatDate(user!.dueDate)),
                  Text(user!.name ?? ""),
                  MaterialButton(
                    color: Color.fromARGB(255, 0, 141, 110),
                    onPressed: _handleSignOut,
                    child: Text(S.of(context).labelSignOut),
                  )
                ],
              )
            : Container());
  }

  void _handleSignOut() {
    _authService.signOut(context, myModel);
  }
}
