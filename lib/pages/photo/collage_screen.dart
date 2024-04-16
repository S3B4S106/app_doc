import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:app_doc/generated/l10n.dart';

class CollageScreen extends StatefulWidget {
  CollageScreen({super.key});
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();
  @override
  _CollageScreenState createState() => _CollageScreenState();
}

class _CollageScreenState extends State<CollageScreen> {
  late Map<DateTime, List<Photo>> _groupedImages;
  late List<Photo> collage = [];

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    _groupedImages = parameters['images'];
    return Scaffold(
        appBar: AppBar(
          title: titleApp(),
          flexibleSpace: header(),
        ),
        body: SizedBox(
          width: GlobalConfig.width,
          height: GlobalConfig.height,
          child: Column(
            children: [
              collage.isNotEmpty
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          height: GlobalConfig.heightPercentage(.20),
                          child: FadeInImage.memoryNetwork(
                            image: collage[0].ruta,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                          ),
                        ),
                        Text(S.of(context).selectAnotherPhoto)
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(8),
                            height: GlobalConfig.heightPercentage(.20),
                            child: Icon(
                              size: GlobalConfig.heightPercentage(.20),
                              Icons.square,
                              color: GlobalConfig.backgroundButtonColor,
                            )),
                        Text(S.of(context).selectPhoto)
                      ],
                    ),
              Container(
                width: GlobalConfig.width,
                height: GlobalConfig.heightPercentage(.60),
                child: ListView.builder(
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (context, index) {
                            final image = images[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (collage.isNotEmpty) {
                                    if (collage[0].ruta == image.ruta) {
                                      collage.remove(image);
                                    } else {
                                      collage.insert(1, image);
                                      Navigator.popAndPushNamed(
                                          context, "/comparative",
                                          arguments: {'images': collage});
                                    }
                                  } else {
                                    collage.add(image);
                                  }
                                });
                              },
                              child: GridTile(
                                  header: collage.isNotEmpty &&
                                          collage[0].ruta == image.ruta
                                      ? GridTileBar(
                                          title: Icon(Icons.check_circle),
                                          backgroundColor: Colors.black54,
                                        )
                                      : Container(),
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
                                  )),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
