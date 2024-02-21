import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:dotted_border/dotted_border.dart';

class CameraScreen extends StatefulWidget {
  final dynamic camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _mostrarGrilla3x3 = true;
  bool _frames = false;

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

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 +
                  (MediaQuery.of(context).size.height * 0.15),
              width: MediaQuery.of(context).size.width,
              child: CameraPreview(_cameraController!,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2 +
                            (MediaQuery.of(context).size.height * 0.15),
                        width: MediaQuery.of(context).size.width,
                        child: _frames ? _mostrarGrilla() : null,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: FloatingActionButton(
                            heroTag: "close",
                            mini: true,
                            backgroundColor: Color.fromARGB(111, 213, 209, 209),
                            child: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  )),
            ),
            Container(
              color: Color.fromRGBO(35, 93, 113, 1),
              height: MediaQuery.of(context).size.height / 2 -
                  (MediaQuery.of(context).size.height * 0.15),
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  for (int i = 0; i < 15; i++)
                    Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "General",
                                  style: TextStyle(
                                      color: Color.fromRGBO(124, 187, 176, 1)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.square_outlined),
                                  color: Color.fromRGBO(124, 187, 176, 1),
                                  onPressed: () {
                                    setState(() {
                                      _frames = false;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.grid_3x3),
                                  color: Color.fromRGBO(124, 187, 176, 1),
                                  onPressed: () {
                                    setState(() {
                                      _frames = true;
                                      _mostrarGrilla3x3 = true;
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.grid_4x4),
                                  color: Color.fromRGBO(124, 187, 176, 1),
                                  onPressed: () {
                                    setState(() {
                                      _frames = true;
                                      _mostrarGrilla3x3 = false;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )),
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

  Widget _mostrarGrilla() {
    if (_mostrarGrilla3x3) {
      Path customPath = Path()
        ..lineTo(0, 200)
        ..moveTo(137, 0)
        ..lineTo(137, 200);

      return LayoutGrid(
        columnSizes: [1.fr, 1.fr, 1.fr],
        rowSizes: [1.fr, 1.fr, 1.fr],
        children: [
          Container(),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          Container(),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          Container(),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          Container(),
        ],
      );
    } else {
      Path customPath = Path()..lineTo(0, 150);

      return LayoutGrid(
        columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
        rowSizes: [1.fr, 1.fr, 1.fr, 1.fr],
        children: [
          Container(),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          Container(),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
          DottedBorder(
            customPath: (size) => customPath,
            dashPattern: [8],
            color: Colors.grey,
            strokeWidth: 1,
            child: Container(),
          ),
        ],
      );
    }
  }
}
