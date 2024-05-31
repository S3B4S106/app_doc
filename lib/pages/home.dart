import 'package:app_doc/features/firebase_services/firebase_auth_services.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/toast.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/features/model/notify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  late final EntitysModel? _entitysModel;
  HomeScreen(EntitysModel entitysModel) {
    _entitysModel = entitysModel;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState(_entitysModel);
}

class _HomeScreenState extends State<HomeScreen> {
  final _passwordController = TextEditingController();
  EntitysModel? _entitysModel;
  final FirebaseAuthService _authService = FirebaseAuthService();

  _HomeScreenState(EntitysModel? entitysModel) {
    _entitysModel = entitysModel;
  }

  @override
  void initState() {
    super.initState();
    if (!_authService.getUser()!.emailVerified) {
      Future.delayed(const Duration(seconds: 1), () {
        showCupertinoModalPopup(
            context: context,
            builder: (_) => PopScope(
                  canPop: false,
                  child: Center(
                      child: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: GlobalConfig.heightPercentage(.35),
                        horizontal: GlobalConfig.widthPercentage(.1)),
                    color: GlobalConfig.secundaryColorApp,
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(
                              textAlign: TextAlign.center,
                              'Correo no verificado',
                              style: TextStyle(
                                  color: GlobalConfig.complementaryColorApp),
                            ),
                            subtitle: Text(
                                'Por favor verifique su correo para poder continuar',
                                style: TextStyle(
                                    color:
                                        GlobalConfig.complementaryColorApp))),
                        SizedBox(
                            width: GlobalConfig.widthPercentage(.6),
                            child: Material(
                                color: GlobalConfig.backgroundButtonColor,
                                elevation: 13,
                                borderRadius: BorderRadius.circular(150),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                    splashColor: Colors.white70,
                                    onTap: () {
                                      _authService.sendEmailVerification();
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: GlobalConfig.borderColor,
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        child: Column(children: [
                                          Text(
                                            'Reenviar Correo',
                                            style: TextStyle(
                                                fontSize: 28,
                                                color: GlobalConfig
                                                    .complementaryColorApp),
                                          ),
                                        ]))))),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: GlobalConfig.widthPercentage(.6),
                            child: Material(
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
                                          borderRadius:
                                              BorderRadius.circular(150),
                                        ),
                                        child: Column(children: [
                                          Text(
                                            S.of(context).labelSignOut,
                                            style: TextStyle(
                                                fontSize: 28,
                                                color: GlobalConfig
                                                    .complementaryColorApp),
                                          ),
                                        ]))))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '¿Ya verificaste tu correo?',
                              style: TextStyle(
                                  color: GlobalConfig
                                      .alternativeComplementaryColorApp),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.popAndPushNamed(context, "/");
                              },
                              child: Text(
                                'Continuar',
                                style: TextStyle(
                                  color: Color.fromRGBO(124, 187, 176, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
                color: GlobalConfig.alternativeComplementaryColorApp,
                Icons.account_circle_rounded),
            onPressed: _openUserInfo,
          ),
          actions: [
            PopupMenuButton(
              color: GlobalConfig.secundaryColorApp,
              position: PopupMenuPosition.under,
              icon: Icon(
                  color: GlobalConfig.alternativeComplementaryColorApp,
                  Icons.menu_rounded),
              onSelected: (dynamic item) {},
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  padding: EdgeInsets.only(left: 10),
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(
                          S.of(context).titleDelete(S.of(context).account),
                          style: TextStyle(
                              color: GlobalConfig.complementaryColorApp),
                        ),
                        content:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            S.of(context).copyDelete,
                            style: TextStyle(
                                color: GlobalConfig.complementaryColorApp),
                          ),
                          _authService
                                      .getUser()!
                                      .providerData
                                      .first
                                      .providerId ==
                                  'password'
                              ? TextFormField(
                                  style: TextStyle(
                                      color: GlobalConfig
                                          .alternativeComplementaryColorApp),
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).labelPassword,
                                      labelStyle: TextStyle(
                                          color: GlobalConfig
                                              .alternativeComplementaryColorApp)),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Ingrese su contraseña';
                                    }
                                    return null;
                                  },
                                )
                              : const SizedBox()
                        ]),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _passwordController.clear();
                              Navigator.pop(context, 'Cancel');
                            },
                            child: Text(S.of(context).cancel),
                          ),
                          TextButton(
                            onPressed: () async {
                              if (await _authService.deleteAccount(
                                  _authService.getUser(),
                                  _passwordController.text,
                                  _authService
                                      .getUser()!
                                      .providerData
                                      .first
                                      .providerId ==
                                  'password',
                                  _entitysModel!)) {
                                _entitysModel!.reset();
                                _authService.closeAll(context, _entitysModel);
                              } else {
                                _passwordController.clear();
                                showToast(message: 'Credenciales invalidas');
                              }
                            },
                            child: Text(S.of(context).delete),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_rounded,
                      color: GlobalConfig.alternativeComplementaryColorApp,
                    ),
                    title: Text(
                      S.of(context).titleDelete(S.of(context).account),
                      style: TextStyle(
                          color: GlobalConfig.alternativeComplementaryColorApp),
                    ),
                  ),
                ),
              ],
            ),
          ],
          flexibleSpace: header(),
          title: titleApp()),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                    vertical: GlobalConfig.heightPercentage(.05)),
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
                    elevation: 12,
                    borderRadius: BorderRadius.circular(57),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: _openNewPx,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: GlobalConfig.borderColor, width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image:
                                    const AssetImage('assets/Button5Grad.png'),
                                height: GlobalConfig.height / 2 - 150,
                                width: GlobalConfig.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                S.of(context).newPacient,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalConfig.textColor),
                              )
                            ]))))),
            Container(
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
                    elevation: 10,
                    borderRadius: BorderRadius.circular(57),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.black87,
                        onTap: _openlistPx,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: GlobalConfig.borderColor, width: 7),
                              borderRadius: BorderRadius.circular(57),
                            ),
                            child: Column(children: [
                              Ink.image(
                                image: const AssetImage(
                                    'assets/BottonlistcleanGrad.png'),
                                height: GlobalConfig.height / 2 - 150,
                                width: GlobalConfig.width - 17,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              Text(
                                S.of(context).pacientsList,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: GlobalConfig.textColor),
                              )
                            ]))))),
          ],
          //color: Colors.black,
        ),
      ),
    );
  }

  void _handleSignOut() {
    _authService.signOut(context, _entitysModel);
  }

  void _openNewPx() {
    Navigator.pushNamed(context, "/newPx", arguments: {'model': _entitysModel});
  }

  void _openlistPx() {
    Navigator.pushNamed(context, "/listPx",
        arguments: {'model': _entitysModel});
  }

  void _openUserInfo() {
    Navigator.pushNamed(context, "/user-info",
        arguments: {'model': _entitysModel});
  }

  void _deleteAccount() async {}
}
