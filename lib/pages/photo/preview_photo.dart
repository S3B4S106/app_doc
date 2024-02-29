import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:flutter/material.dart';

class PreviewPageScreen extends StatefulWidget {
  late final File? image;

  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();

  PreviewPageScreen({super.key, this.image});
  @override
  _PreviewPageScreenState createState() => _PreviewPageScreenState();
}

class _PreviewPageScreenState extends State<PreviewPageScreen> {
  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    widget.image = parameters['image'];
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 10,
            child: Image.file(widget.image!),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 10,
            child: TextButton(
              child: Text('Save'),
              onPressed: () async {
                String urlImage = await widget._storageService.uploadFile(
                    widget.image!, DateTime.now().toIso8601String());
                Photo newPhoto = Photo(
                    nombre: "nombre",
                    fecha: DateTime.now(),
                    tipo: "tipo",
                    ruta: urlImage);
                widget._dbService
                    .addItem("fotos", newPhoto, parameters['pacient'].uid);

                Navigator.pop(context);
              },
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
