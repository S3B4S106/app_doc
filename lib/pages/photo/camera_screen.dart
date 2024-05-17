import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/global/accelerometer.dart';
import 'package:app_doc/features/global/camera_widgets.dart';
import 'package:app_doc/features/global/commun/iconsapp_icons.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final dynamic camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  RotationAngleDetector? _rotationAngleDetector;
  CameraController? _cameraController;
  String _category = 'G';
  bool _photo = true;
  double _valueRotation = 0.0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _rotationAngleDetector =
        RotationAngleDetector(onRotationAngleUpdate: _updateRotationAngle);
    _initCamera();
  }

  void _updateRotationAngle(double rotationAngle) {
    setState(() {
      _valueRotation = rotationAngle;
    });
  }

  void _initCamera() async {
    _cameraController = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _cameraController!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _rotationAngleDetector!.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  Widget buildCategory(context, title, icons, category) {
    return Container(
        margin: EdgeInsets.only(left: GlobalConfig.widthPercentage(.1)),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color: GlobalConfig.textColor),
                )
              ],
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    width: GlobalConfig.width,
                    child: Row(
                      children: [
                        for (final icon in icons)
                          IconButton(
                            icon: Icon(icon),
                            color:
                                GlobalConfig.alternativeComplementaryColorApp,
                            highlightColor: GlobalConfig.secundaryColorApp,
                            iconSize: GlobalConfig.heightPercentage(0.06),
                            onPressed: () {
                              setState(() {
                                _category = category;
                              });
                              _showTemplate(icons.indexOf(icon));
                            },
                          ),
                      ],
                    ))),
          ],
        ));
  }

  void _showTemplate(int template) {
    _pageController.animateToPage(template,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SizedBox(
        width: GlobalConfig.width,
        child: Column(
          children: [
            Container(
                height: GlobalConfig.heightPercentage(.65),
                width: GlobalConfig.width,
                child: cameraWidget(_valueRotation, _cameraController, context,
                    _category, _pageController, _photo, parameters['photo'])),
            Container(
              color: GlobalConfig.backgroundColor,
              height: GlobalConfig.heightPercentage(.35),
              width: GlobalConfig.width,
              child: ListView(
                children: <Widget>[
                  buildCategory(
                      context,
                      S.of(context).basic,
                      [
                        Icons.square_outlined,
                        Icons.grid_3x3,
                        Icons.grid_4x4_outlined
                      ],
                      "G"),
                  buildCategory(
                      context,
                      S.of(context).advanced,
                      [
                        Iconsapp.front,
                        Iconsapp.draftL,
                        Iconsapp.draftR,
                        Iconsapp.left,
                        Iconsapp.right,
                        Iconsapp.back,
                      ],
                      "A")
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "camera",
        backgroundColor: GlobalConfig.primaryColorApp,
        child: Icon(
            color: GlobalConfig.backgroundColor,
            Icons.camera_alt_outlined,
            size: GlobalConfig.heightPercentage(0.05)),
        onPressed: () async {
          final image = await _cameraController!.takePicture();
          Navigator.pushNamed(context, '/preview-photo', arguments: {
            'image': File(image.path),
            'pacient': parameters['pacient']
          });

          // Guardar la foto con la grilla aplicada
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
