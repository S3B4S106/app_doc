import 'dart:io';
import 'dart:ui';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/firebase_services/firebase_realtimedb_services.dart';
import 'package:app_doc/features/firebase_services/firebase_storage_services.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/commun/progress_dialog.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:app_doc/features/global/commun/iconsapp_icons.dart';

class ComparativeScreen extends StatefulWidget {
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseRealTimeDbService _dbService = FirebaseRealTimeDbService();
  ComparativeScreen({super.key});

  @override
  _ComparativeScreenState createState() => _ComparativeScreenState();
}

class _ComparativeScreenState extends State<ComparativeScreen> {
  Photo? _image1;
  Photo? _image2;
  double _image2Offset = 0.5;
  bool orientation = true;
  bool version = true;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    //createListener(parameters['model'], parameters['pacient']);
    _image1 = parameters['images'][0];
    _image2 = parameters['images'][1];
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: GlobalConfig.alternativeComplementaryColorApp),
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: GlobalConfig.heightPercentage(.6),
            width: GlobalConfig.width,
            child: version
                ? orientation
                    ? Container(
                        margin: EdgeInsets.only(
                            top: GlobalConfig.heightPercentage(.6) * 0.03,
                            right: GlobalConfig.widthPercentage(.2),
                            left: GlobalConfig.widthPercentage(.2)),
                        child: Column(children: scroll(key)))
                    : Container(
                        margin: EdgeInsets.only(
                            left: GlobalConfig.widthPercentage(.17),
                            top: GlobalConfig.heightPercentage(.02),
                            bottom: GlobalConfig.heightPercentage(.02)),
                        child: Row(children: scroll(key)))
                : orientation
                    ? RepaintBoundary(key:key,child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: alignet(
                            GlobalConfig.widthPercentage(.4), null, 0, 0),
                      ))
                    : RepaintBoundary(key:key, child:Column(
                        children: alignet(
                            null,
                            GlobalConfig.heightPercentage(.26),
                            0,
                            GlobalConfig.heightPercentage(.01)),
                      )),
          ),
          Container(
            color: GlobalConfig.backgroundColor,
            width: GlobalConfig.width,
            height: GlobalConfig.heightPercentage(.2),
            child: ListView(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(
                        vertical: GlobalConfig.heightPercentage(.02)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Iconsapp.resize_horizontal,
                                size: GlobalConfig.heightPercentage(0.06),
                              ),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = true;
                                  version = true;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Iconsapp.resize_vertical,
                                size: GlobalConfig.heightPercentage(0.06),
                              ),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = false;
                                  version = true;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Iconsapp.vertical_alignment_ya204mf6yqye,
                                size: GlobalConfig.heightPercentage(0.06),
                              ),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = false;
                                  version = false;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Iconsapp.vertical_alignment_yu5lza7okstz,
                                size: GlobalConfig.heightPercentage(0.06),
                              ),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = true;
                                  version = false;
                                });
                              },
                            ),
                          ],
                        ),
                        
                        Container(
                          margin:EdgeInsets.only(top: GlobalConfig.heightPercentage(.02)),
            width: GlobalConfig.width,
                child: Material(
                    color: GlobalConfig.backgroundButtonColor,
                    elevation: 13,
                    borderRadius: BorderRadius.circular(150),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                        splashColor: Colors.white70,
                        onTap: () async{
                          ProgressDialog.show(context);
                           final boundary =
                                    key.currentContext?.findRenderObject()
                                        as RenderRepaintBoundary?;
                                final image = await boundary?.toImage();
                                final byteData = await image?.toByteData(
                                    format: ImageByteFormat.png);
                                final imageBytes =
                                    byteData?.buffer.asUint8List();

                                if (imageBytes != null) {
                                  final directorio_en_cache =
                                      await getTemporaryDirectory();

                                  File tu_archivo_file = await File(
                                          '${directorio_en_cache.path}/image.png')
                                      .create();
                                  tu_archivo_file.writeAsBytesSync(imageBytes);
                                  DateTime currentDate = DateTime.now();
                                  String urlImage = await widget._storageService
                                      .uploadFile(tu_archivo_file,
                                          '${parameters["pacient"].id}/${currentDate.toIso8601String()}');
                                  Photo newPhoto = Photo(
                                      nombre: currentDate.toIso8601String(),
                                      fecha: currentDate,
                                      tipo: "image",
                                      ruta: urlImage);
                                  widget._dbService.addItem("fotos", newPhoto,
                                      parameters['pacient'].uid);}
                                      Navigator.popUntil(context, (route) => route.settings.name == '/fotos');
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
                            ])))))
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> scroll(key) {
    return [
      RepaintBoundary(
          key: key,
          child: Stack(
            children: <Widget>[
              _image1 != null
                  ? FadeInImage.memoryNetwork(
                      image: _image1!.ruta,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                    )
                  : Container(),
              _image2 != null
                  ? ClipPath(
                      clipper: MycustomClippper(_image2Offset, orientation),
                      child: FadeInImage.memoryNetwork(
                        image: _image2!.ruta,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                      ))
                  : Container(),
            ],
          )),
      SfSliderTheme(
          data: SfSliderThemeData(
              inactiveTrackHeight: 0,
              activeTrackHeight: 0,
              thumbRadius: 17,
              thumbColor: GlobalConfig.primaryColorApp),
          child: RotatedBox(
            quarterTurns: orientation ? 0 : 1,
            child: SfSlider(
              thumbIcon: Icon(Iconsapp.left_and_right_11wtecpnwuem),
              value: _image2Offset,
              min: 0.0,
              max: 1.0,
              onChanged: (dynamic value) {
                setState(() {
                  _image2Offset = value;
                });
              },
            ),
          )),
    ];
  }

  List<Widget> alignet(double? width, double? height, double left, double top) {
    return <Widget>[
      _image1 != null
          ? Container(
              margin: EdgeInsets.only(left: left, top: top),
              height: height,
              width: width,
              child: FadeInImage.memoryNetwork(
                image: _image1!.ruta,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
              ),
            )
          : Container(),
      _image2 != null
          ? Container(
              margin: EdgeInsets.only(top: top),
              height: height,
              width: width,
              child: FadeInImage.memoryNetwork(
                image: _image2!.ruta,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
              ),
            )
          : Container(),
    ];
  }
}

class MycustomClippper extends CustomClipper<Path> {
  double offset;
  bool vertical;
  MycustomClippper(this.offset, this.vertical);

  @override
  Path getClip(Size size) {
    Path path = Path();
    if (vertical) {
      path = Path()
        ..lineTo(0, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width * offset, size.height)
        ..lineTo(size.width * offset, 0);
    } else {
      path = Path()
        ..lineTo(0, 0)
        ..lineTo(0, size.height * offset)
        ..lineTo(size.width, size.height * offset)
        ..lineTo(size.width, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
