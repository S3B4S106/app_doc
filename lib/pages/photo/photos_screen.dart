import 'package:app_doc/pages/photo/camera_screen.dart';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:camera/camera.dart';
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
      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, "/camera",
                              arguments: {'pacient': parameters['pacient']});
                        },
                        icon: Icon(Icons.add_a_photo_outlined)),
                    SizedBox(width: 40),
                    Icon(Icons.add_photo_alternate_outlined),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.compare)
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
