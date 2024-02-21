import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularPercentIndicator(
            animation: true,
            radius: 200,
            lineWidth: 20,
            percent: 0.75,
            backgroundColor: Color.fromRGBO(35, 93, 113, 1), //35, 93, 113, 1
            progressColor: Color.fromRGBO(165, 219, 195, 1), //165, 219, 195, 1
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
          Text(
            user!.name ?? "",
            style: const TextStyle(
                fontSize: 30, color: Color.fromRGBO(122, 188, 176, 1)),
          ),
          Text(
            user.dueDate != null ? formatDate(user!.dueDate) : "Basico",
            style: const TextStyle(
                fontSize: 17, color: Color.fromRGBO(122, 188, 176, 1)),
          ),
          MaterialButton(
            color: Color.fromARGB(255, 0, 141, 110),
            onPressed: _handleSignOut,
            child: Text(
              S.of(context).labelSignOut,
              style: TextStyle(
                  fontSize: 32, color: Color.fromRGBO(221, 252, 212, 1)),
            ),
          )
        ],
      ),
    );
  }

  void _handleSignOut() {
    _authService.signOut(context, myModel);
  }
}
