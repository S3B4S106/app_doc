import 'dart:io';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/pages/pacient/pacient_list.dart';
import 'package:app_doc/features/entity/photo.dart';
import 'package:flutter/material.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen();

  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final fotos = <Photo>[];
  Pacient? paciente;

  @override
  Widget build(BuildContext context) {
    paciente = ModalRoute.of(context)?.settings.arguments as Pacient;
    fotos.addAll(paciente!.fotos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotos"),
      ),
      body: ListView(
        children: [
          // Listamos las fotos
          for (final foto in fotos)
            Image.network(
              foto.ruta,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
