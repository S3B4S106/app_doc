import 'dart:io';
import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/progress_dialog.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:photo_view/photo_view.dart';

class PreviewPageScreen extends StatefulWidget {
  File? image;

  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();

  PreviewPageScreen({super.key, this.image});
  @override
  _PreviewPageScreenState createState() => _PreviewPageScreenState();
}

class _PreviewPageScreenState extends State<PreviewPageScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    widget.image = parameters['image'];
    Map <String,String> info = parameters['info'];
    print(info);
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              color: Colors.black,
              margin: EdgeInsets.symmetric(
                  vertical: GlobalConfig.heightPercentage(.1),
                  horizontal: GlobalConfig.widthPercentage(.1)),
              height: GlobalConfig.heightPercentage(.50),
              width: GlobalConfig.widthPercentage(.9),
              child: PhotoView(
                imageProvider: FileImage(widget.image!),
              )),
          Container(
              width: GlobalConfig.width,
              child: Material(
                  color: GlobalConfig.backgroundButtonColor,
                  elevation: 13,
                  borderRadius: BorderRadius.circular(150),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                      splashColor: Colors.white70,
                      onTap: () async {
                        ProgressDialog.show(context);
                        DateTime currentDate = DateTime.now();
                        String urlImage = await widget._storageService.uploadFile(
                            widget.image!,
                            '${parameters["pacient"].id}/${currentDate.toIso8601String()}');
                        Photo newPhoto = Photo(
                            nombre: currentDate.toIso8601String(),
                            fecha: currentDate,
                            tipo: info['format'] ?? 'JPG',
                            angle: info['angle'] ?? '0',
                            template: getTemplate(info['template']??''),
                            ruta: urlImage);
                        widget._dbService.addItem(
                            "fotos", newPhoto, parameters['pacient'].uid);

                        Navigator.popUntil(context,
                            (route) => route.settings.name == '/fotos');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color: GlobalConfig.borderColor, width: 3),
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: Column(children: [
                            Text(
                              S.of(context).submit,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: GlobalConfig.complementaryColorApp),
                            ),
                          ]))))),
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
