import 'dart:collection';
import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosScreen extends StatefulWidget {
  PhotosScreen({super.key});
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();
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
        iconTheme:
            IconThemeData(color: GlobalConfig.alternativeComplementaryColorApp),
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: Column(children: [
        ListTile(
            title: Container(
                alignment: Alignment.center,
                child: Text(
                  parameters['pacient'].userName,
                  style: TextStyle(
                      color: GlobalConfig.complementaryColorApp,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            subtitle: Container(
                alignment: Alignment.center,
                child: Text(
                  parameters['pacient'].id,
                  style: TextStyle(color: GlobalConfig.complementaryColorApp),
                ))),
        SizedBox(
          height: GlobalConfig.heightPercentage(.7),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: _groupedImages.length,
            itemBuilder: (context, index) {
              final date = _groupedImages.keys.toList()[index];
              final images = _groupedImages[date]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: GlobalConfig.width * 0.02),
                    child: Text(
                      formatDate(date),
                      style: TextStyle(
                        color: GlobalConfig.alternativeComplementaryColorApp,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                              style: TextStyle(
                                  color: GlobalConfig
                                      .alternativeComplementaryColorApp),
                              formatDate(image.fecha),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/photo-info',
                                    arguments: {
                                      'images': _groupedImages,
                                      'image': image,
                                      'pacient': parameters['pacient']
                                    });
                              },
                              child: FadeInImage.memoryNetwork(
                                image: image.ruta,
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                              )));
                    },
                  ),
                ],
              );
            },
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalConfig.primaryColorApp,
        heroTag: "add",
        child: Icon(color: GlobalConfig.backgroundColor, Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheet(
              backgroundColor: GlobalConfig.backgroundColor,
              onClosing: () {},
              builder: (context) => Container(
                height: GlobalConfig.heightPercentage(.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, "/camera",
                              arguments: {'pacient': parameters['pacient']});
                        },
                        icon: Icon(
                            color:
                                GlobalConfig.alternativeComplementaryColorApp,
                            Icons.add_a_photo_outlined)),
                    SizedBox(width: 40),
                    IconButton(
                        onPressed: () async {
                          var picker = ImagePicker();
                          dynamic image = await picker.pickImage(
                              source: ImageSource.gallery, imageQuality: 50);
                          image = File(image.path);
                          DateTime currentDate = DateTime.now();
                          String urlImage = await widget._storageService.uploadFile(
                              image!,
                              '${parameters["pacient"].id}/${currentDate.toIso8601String()}');
                          Photo newPhoto = Photo(
                              nombre: currentDate.toIso8601String(),
                              fecha: currentDate,
                              tipo: "image",
                              ruta: urlImage);
                          widget._dbService.addItem(
                              "fotos", newPhoto, parameters['pacient'].uid);
                        },
                        icon: Icon(
                            color:
                                GlobalConfig.alternativeComplementaryColorApp,
                            Icons.add_photo_alternate_outlined)),
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/collage", arguments: {
                            "images": _groupedImages,
                            'pacient': parameters['pacient']
                          });
                        },
                        icon: Icon(
                            color:
                                GlobalConfig.alternativeComplementaryColorApp,
                            Icons.compare))
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
