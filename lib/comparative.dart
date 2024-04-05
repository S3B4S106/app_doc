import 'dart:io';

import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class ComparativeScreen extends StatefulWidget {
  ComparativeScreen({super.key});

  @override
  _ComparativeScreenState createState() => _ComparativeScreenState();
}

class _ComparativeScreenState extends State<ComparativeScreen> {
  Photo? _image1;
  Photo? _image2;
  double _image2Offset = 0.5;

  void _onSliderChanged(double value) {
    setState(() {
      _image2Offset = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map parameters = ModalRoute.of(context)?.settings.arguments as Map;
    //createListener(parameters['model'], parameters['pacient']);
    _image1 = parameters['images'][0];
    _image2 = parameters['images'][1];
    return Scaffold(
      appBar: AppBar(
        title: titleApp(),
        flexibleSpace: header(),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    _image1 != null
                        ? Container(
                            height: GlobalConfig.heightPercentage(.50),
                            width: GlobalConfig.width,
                            child: FadeInImage.memoryNetwork(
                              image: _image1!.ruta,
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                            ),
                          )
                        : Container(),
                    _image2 != null
                        ? Container(
                            height: GlobalConfig.heightPercentage(.50),
                            width: GlobalConfig.width,
                            child: ClipPath(
                                clipper: MycustomClippper(_image2Offset),
                                child: FadeInImage.memoryNetwork(
                                  image: _image2!.ruta,
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                )),
                          )
                        : Container(),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: GlobalConfig.heightPercentage(.25),
                      child: SliderTheme(
                        data: const SliderThemeData(
                          thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius:
                                  10), // Punto de control circular
                          trackHeight: 0, // Ocultar la barra
                        ),
                        child: Slider(
                          value: _image2Offset,
                          min: 0.0,
                          max: 1.0,
                          onChanged: _onSliderChanged,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MycustomClippper extends CustomClipper<Path> {
  double offset;
  MycustomClippper(this.offset);

  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width * offset, size.height)
      ..lineTo(size.width * offset, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
