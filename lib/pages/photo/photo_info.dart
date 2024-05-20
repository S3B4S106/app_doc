import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/progress_dialog.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class PhotoInfoPageScreen extends StatefulWidget {
  Photo? image;

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
            margin: EdgeInsets.only(
              left: GlobalConfig.widthPercentage(0.1),
              right: GlobalConfig.widthPercentage(0.1),
              top: GlobalConfig.heightPercentage(0.09),
            ),
            height: GlobalConfig.heightPercentage(.6),
            width: GlobalConfig.widthPercentage(.9),
            child: Image.network(widget.image!.ruta),
          ),
          Container(
            margin: EdgeInsets.only(top: GlobalConfig.heightPercentage(.1)),
            width: GlobalConfig.widthPercentage(.9),
            height: GlobalConfig.heightPercentage(.1),
            color: GlobalConfig.primaryColorApp,
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: GlobalConfig.widthPercentage(.2)),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                        width: GlobalConfig.width,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/collage",
                                      arguments: {
                                        "image": widget.image,
                                        "images": parameters['images'],
                                        'pacient': parameters['pacient']
                                      });
                                },
                                icon: Icon(
                                    color: GlobalConfig
                                        .alternativeComplementaryColorApp,
                                    Icons.compare)),
                            IconButton(
                                onPressed: () async {
                                  ProgressDialog.show(context);
                                  XFile image = await getImageXFileByUrl(
                                      widget.image!.ruta);
                                  Navigator.pop(context);
                                  final result = await Share.shareXFiles(
                                      [image],
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
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/camera",
                                      arguments: {
                                        'pacient': parameters['pacient'],
                                        'photo': widget.image
                                      });
                                },
                                icon: Icon(
                                    color: GlobalConfig
                                        .alternativeComplementaryColorApp,
                                    Icons.photo_library_outlined)),
                            IconButton(
                                onPressed: () {
                                _showActionSheet(context,parameters);
                                },
                                icon: Icon(
                                    color: GlobalConfig
                                        .alternativeComplementaryColorApp,
                                    Icons.delete))
                          ],
                        )))),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        heroTag: "close",
        mini: true,
        child: Icon(color: GlobalConfig.primaryColorApp, Icons.close_rounded),
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
  
  void _showActionSheet(BuildContext context, parameters) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Delete photo?'),
        message: const Text('This action cannot be undone'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// default behavior, turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              widget._dbService.removeItem(
                                      'fotos',
                                      parameters['pacient'].uid,
                                      widget.image!.uid!);
                                  widget._storageService.removeFile(
                                      name:
                                          '${parameters['pacient'].id}/${widget.image!.fecha.toIso8601String()}');
              Navigator.popUntil(context, (route) => route.settings.name == '/fotos');
            },
            child: const Text('Delete'),
          ),
          
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    XFile result = await XFile(file.path);
    return result;
  }
}
