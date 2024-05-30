import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/global_config.dart';
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
            ? Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalConfig.heightPercentage(.02),
                    horizontal: GlobalConfig.widthPercentage(.05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      user!.name ?? "",
                      style: TextStyle(
                          fontSize: 30, color: GlobalConfig.textColor),
                    ),
                    Text(
                      myModel.getPlan(user!.suscriptionType) != null
                          ? myModel.getPlan(user!.suscriptionType).name
                          : "Free",
                      style: TextStyle(
                          fontSize: 17, color: GlobalConfig.textColor),
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
                      percent: myModel.getPlan(user!.suscriptionType) != null
                          ? myModel.fotos *
                              1 /
                              myModel.getPlan(user!.suscriptionType).limit
                          : 0,
                      backgroundColor:
                          GlobalConfig.primaryColorApp, //35, 93, 113, 1
                      progressColor:
                          Color.fromRGBO(165, 219, 195, 1), //165, 219, 195, 1
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        myModel.getPlan(user!.suscriptionType) != null
                            ? '${myModel.fotos * 100 / myModel.getPlan(user!.suscriptionType).limit}%'
                            : '0%',
                        style: TextStyle(
                            color:
                                GlobalConfig.alternativeComplementaryColorApp),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: Text(
                        '${myModel.fotos}  / ${myModel.getPlan(user!.suscriptionType) != null ? myModel.getPlan(user!.suscriptionType).limit : 0}',
                        style: TextStyle(
                            color:
                                GlobalConfig.alternativeComplementaryColorApp),
                      ),
                    ),
                    Material(
                        color: GlobalConfig.backgroundButtonColor,
                        elevation: 13,
                        borderRadius: BorderRadius.circular(150),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                            splashColor: Colors.white70,
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: GlobalConfig.borderColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(150),
                                ),
                                child: Column(children: [
                                  Text(
                                    S.of(context).changeSubscrip,
                                    style: TextStyle(
                                        fontSize: 28,
                                        color:
                                            Color.fromRGBO(221, 252, 212, 1)),
                                  ),
                                ])))),
                    Container(
                      height: 35,
                      width: 100,
                    ),
                    Material(
                        color: GlobalConfig.backgroundButtonColor,
                        elevation: 13,
                        borderRadius: BorderRadius.circular(150),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                            splashColor: Colors.white70,
                            onTap: _handleSignOut,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: GlobalConfig.borderColor,
                                      width: 3),
                                  borderRadius: BorderRadius.circular(150),
                                ),
                                child: Column(children: [
                                  Text(
                                    S.of(context).labelSignOut,
                                    style: TextStyle(
                                        fontSize: 28,
                                        color:
                                            Color.fromRGBO(221, 252, 212, 1)),
                                  ),
                                ]))))
                  ],
                ))
            : Container());
  }

  void _handleSignOut() {
    _authService.signOut(context, myModel);
  }
}
