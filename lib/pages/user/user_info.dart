import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var user;
  var auth;
  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    user = parameters['user'];
    auth = parameters['service'];
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        //backgroundColor: Color.fromRGBO(35, 93, 113, 1),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromRGBO(35, 93, 113, 1),
              Color.fromRGBO(124, 187, 176, 1)
            ],
          )),
        ),
        title: const Text("P x P h o t o P r o"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 100,
            width: 100,
          ),
          Text(user!.email ?? ""),
          Text(user!.displayName ?? ""),
          MaterialButton(
            color: Color.fromARGB(255, 0, 141, 110),
            onPressed: _handleSignOut,
            child: const Text("Sign Out"),
          )
        ],
      ),
    );
  }

  void _handleSignOut() {
    auth.signOut();
    Navigator.pushNamed(context, "/login");
  }
}
