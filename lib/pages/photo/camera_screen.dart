import 'dart:io';

import 'package:app_doc/features/global/camera_widgets.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final dynamic camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  String _category = 'G';
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _initCamera();
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
    _cameraController?.dispose();
    super.dispose();
  }

  Widget buildCategory(context, title, icons, category) {
    return Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Color.fromRGBO(124, 187, 176, 1)),
                )
              ],
            ),
            Row(
              children: [
                for (final icon in icons)
                  IconButton(
                    icon: Icon(icon),
                    color: Color.fromRGBO(124, 187, 176, 1),
                    onPressed: () {
                      setState(() {
                        _category = category;
                      });
                      _showTemplate(icons.indexOf(icon));
                    },
                  ),
              ],
            ),
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2 +
                    (MediaQuery.of(context).size.height * 0.15),
                width: MediaQuery.of(context).size.width,
                child: cameraWidget(
                    _cameraController, context, _category, _pageController)),
            Container(
              color: Color.fromRGBO(35, 93, 113, 1),
              height: MediaQuery.of(context).size.height / 2 -
                  (MediaQuery.of(context).size.height * 0.15),
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  buildCategory(
                      context,
                      'Basic',
                      [
                        Icons.square_outlined,
                        Icons.grid_3x3,
                        Icons.grid_4x4_outlined
                      ],
                      "G"),
                  buildCategory(
                      context,
                      'Avanced',
                      [
                        Icons.square_outlined,
                        Icons.square_outlined,
                        Icons.face_4_outlined
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
        child: Icon(Icons.camera_alt_outlined, size: 40),
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
