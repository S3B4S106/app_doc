import 'dart:collection';
import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/progress_dialog.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/entity/pacient.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
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
  List<Photo> selectedImages = [];
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
          height: GlobalConfig.heightPercentage(.6),
          child: buildGallery(pacient: parameters['pacient'] ),
          
        ),
        if (selectedImages.isNotEmpty)
          handleModalBottom(parameters)
      ]),
      floatingActionButton: 
      selectedImages.isEmpty ?
        FloatingActionButton(
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
                      const SizedBox(width: 40),
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
                      const SizedBox(
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
        ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildGallery({required Pacient pacient}){
    const padding = EdgeInsets.all(8.0);

    return ListView.builder(
            padding:  padding,
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
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:  padding,
                    itemCount: images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) {
                      Icon iconCheck = const Icon(Icons.check_circle_outlined);
                      Function handleLongPress = selectedImage;
                      Function handleOneTap = openOptionsImage;
                      if ( selectedImages.isNotEmpty ){
                        if(selectedImages.contains(images[index])){
                          iconCheck =  const Icon(Icons.check_circle_rounded);
                        }
                        handleOneTap = selectedImage;
                         
                      }
                      Widget headerPhoto = selectedImages.isEmpty ? Container(): GridTileBar(title: Align(alignment: AlignmentDirectional.topEnd,child:iconCheck) ,);
                      final image = images[index];
                      return GridTile(
                          header: headerPhoto,
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
                              onLongPress:(){ 
                                HapticFeedback.heavyImpact();
                                setState(() {
                                  handleLongPress(image:image);
                                });
                              },
                              onTap: () {
                                setState(() {
                                  handleOneTap(image:image,pacient:pacient);
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
          );
  }

  void selectedImage({required image, pacient=''}){
      if(selectedImages.contains(image)){
        selectedImages.remove(image);
      }else{
        selectedImages.add(image);
      }
  }

  void _showActionSheet(BuildContext context, parameters) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: [
          containerCopertino(Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    S.of(context).titleDelete(S.of(context).photo),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: GlobalConfig.complementaryColorApp,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(S.of(context).copyDelete,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 10,
                        color: GlobalConfig.complementaryColorApp,
                      )))
            ],
          )),
          containerCopertino(CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              for(Photo photo in selectedImages){
                widget._dbService.removeItem('fotos', parameters['pacient'].uid,
                  idItem: photo.uid!);
                widget._storageService.removeFile(
                    name:
                        '${parameters['pacient'].id}/${photo.fecha.toIso8601String()}');
              }
              
              Navigator.popUntil(
                  context, (route) => route.settings.name == '/fotos');
            },
            child: Text(
              S.of(context).delete,
              style: const TextStyle(color: Colors.cyan),
            ),
          )),
          containerCopertino(CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).cancel),
          ))
        ],
      ),
    );
  }

  void openOptionsImage({required image,required pacient}){
    Navigator.pushNamed(context, '/photo-info',
      arguments: {
        'images': _groupedImages,
        'image': image,
        'pacient': pacient
      });
  }

  Widget handleModalBottom(parameters){
    return AnimatedOpacity(opacity: 1, duration: Duration(milliseconds: 500), child:BottomSheet(elevation: 10, onClosing: (){}, builder: (context) => Container(
                height: GlobalConfig.heightPercentage(.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      ProgressDialog.show(context);
                      List<XFile> images = await getImageXFileByUrl(
                          selectedImages);
                      Navigator.pop(context);
                      final result = await Share.shareXFiles(
                          images,
                          text: 'Great picture');

                      if (result.status ==
                          ShareResultStatus.success) {
                        print('Thank you for sharing the picture!');
                      }
                    },
                    icon: Icon(
                        color: GlobalConfig
                            .alternativeComplementaryColorApp,
                        Icons.ios_share_rounded)),
                    const SizedBox(
                      width: 40,
                    ),
                   IconButton(
                                onPressed: () {
                                  _showActionSheet(context, parameters);
                                },
                                icon: Icon(
                                    color: GlobalConfig
                                        .alternativeComplementaryColorApp,
                                    Icons.delete))
                  ],
                ),
              ),));
  }
}
