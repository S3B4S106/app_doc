import 'package:app_doc/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/photo.dart';
import 'package:app_doc/photo_collection.dart';
import 'package:app_doc/photo_analysis.dart';
import 'package:google_sign_in/testing.dart';

class ListPxScreen extends StatefulWidget {
  @override
  _ListPxScreenState createState() => _ListPxScreenState();
}

class _ListPxScreenState extends State<ListPxScreen> {
  //var ;
  @override
  void initState() {
    //   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de Pacientes"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
