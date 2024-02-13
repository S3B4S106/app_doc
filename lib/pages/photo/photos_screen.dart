import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:flutter/material.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen();

  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  var fotos;
  Pacient? paciente;

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    parameters['model'].addListener(() {
      setState(() {});
    });
    fotos = [];
    fotos.addAll(parameters['pacient']!.fotos);
    return Scaffold(
      appBar: AppBar(
        title: titleApp(),
        flexibleSpace: header(),
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
