import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/photo/photo_collection.dart';
import 'package:app_doc/features/photo/photo_analysis.dart';
import 'package:google_sign_in/testing.dart';

class NewPxScreen extends StatefulWidget {
  @override
  _NewPxScreenState createState() => _NewPxScreenState();
}

class _NewPxScreenState extends State<NewPxScreen> {
  //var ;
  @override
  void initState() {
    //   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Paciente"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
