import 'dart:collection';
import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen({super.key});
  FirebaseStorageService _storageService = FirebaseStorageService();
  FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();
  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  var fotos = [];
  Pacient? paciente;
  late Map<DateTime, List<Photo>> _groupedImages;

  void createListener(dynamic model, dynamic pacient) {
    fotos = pacient.fotos ?? [];
    _groupedImages = {};
    for (final foto in fotos) {
      final date = DateTime.parse(formatDate(foto.fecha, order: 2));
      if (!_groupedImages.containsKey(date)) {
        _groupedImages[date] = [foto];
      } else {
        _groupedImages[date]!.add(foto);
      }
    }
    _groupedImages.forEach((date, images) {
      images.sort((a, b) => b.fecha.compareTo(a.fecha));
    });
    _groupedImages = SplayTreeMap<DateTime, List<Photo>>.from(
        _groupedImages, (a, b) => b.compareTo(a));
    model.addListener(() {
      if (this.mounted) {
        setState(() {
          // Your state change code goes here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    createListener(parameters['model'], parameters['pacient']);
    return Scaffold(
      appBar: AppBar(
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _groupedImages.length,
        itemBuilder: (context, index) {
          final date = _groupedImages.keys.toList()[index];
          final images = _groupedImages[date]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatDate(date),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8.0),
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final image = images[index];
                  return GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(
                        formatDate(image.fecha),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: FadeInImage.memoryNetwork(
                      image: image.ruta,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                    ),
                  );
                },
              ),
            ],
          );
        },
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
                    IconButton(
                        onPressed: () async {
                          var picker = ImagePicker();
                          dynamic image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          image = File(image.path);
                          String urlImage = await widget._storageService
                              .uploadFile(
                                  image!, DateTime.now().toIso8601String());
                          Photo newPhoto = Photo(
                              nombre: "nombre",
                              fecha: DateTime.now(),
                              tipo: "tipo",
                              ruta: urlImage);
                          widget._dbService.addItem(
                              "fotos", newPhoto, parameters['pacient'].uid);
                        },
                        icon: Icon(Icons.add_photo_alternate_outlined)),
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
