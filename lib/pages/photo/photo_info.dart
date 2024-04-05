import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';

class PhotoInfoPageScreen extends StatefulWidget {
  String? image;

  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();

  PhotoInfoPageScreen({super.key, this.image});
  @override
  _PhotoInfoPageScreenState createState() => _PhotoInfoPageScreenState();
}

class _PhotoInfoPageScreenState extends State<PhotoInfoPageScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    widget.image = parameters['image'];
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: GlobalConfig.heightPercentage(.50),
            width: GlobalConfig.widthPercentage(.9),
            child: Image.network(widget.image!),
          ),
          Container(
            height: GlobalConfig.heightPercentage(.50),
            width: GlobalConfig.widthPercentage(90),
            child: TextButton(
              child: Text('info'),
              onPressed: () async {},
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "close",
        mini: true,
        child: Icon(Icons.close_rounded),
        onPressed: () async {
          setState(() {
            Navigator.pop(context);
          });

          // Guardar la foto con la grilla aplicada
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
    );
  }
}
