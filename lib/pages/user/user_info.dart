import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/gobal_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    user!.name ?? "",
                    style:
                        TextStyle(fontSize: 30, color: GlobalConfig.textColor),
                  ),
                  Text(
                    user.dueDate != null ? formatDate(user!.dueDate) : "Basico",
                    style:
                        TextStyle(fontSize: 17, color: GlobalConfig.textColor),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                  ),
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 2750,
                    radius: 200,
                    lineWidth: 20,
                    percent: 0.75,
                    backgroundColor:
                        GlobalConfig.primaryColorApp, //35, 93, 113, 1
                    progressColor:
                        Color.fromRGBO(165, 219, 195, 1), //165, 219, 195, 1
                    circularStrokeCap: CircularStrokeCap.round,
                    center: const Icon(
                      Icons.storage_outlined,
                      color: Color.fromRGBO(165, 219, 195, 1),
                      size: 100,
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                  ),
                  MaterialButton(
                    color: Color.fromARGB(255, 0, 141, 110),
                    onPressed: _handleSignOut,
                    child: Text(
                      S.of(context).labelSignOut,
                      style: TextStyle(
                          fontSize: 32,
                          color: Color.fromRGBO(221, 252, 212, 1)),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                  ),
                  MaterialButton(
                    color: Color.fromARGB(255, 0, 141, 110),
                    onPressed: _handleSignOut,
                    child: Text(
                      S.of(context).labelSignOut,
                      style: TextStyle(
                          fontSize: 32,
                          color: Color.fromRGBO(221, 252, 212, 1)),
                    ),
                  )
                ],
              )
            : Container());
  }

  void _handleSignOut() {
    _authService.signOut(context, myModel);
  }
}
