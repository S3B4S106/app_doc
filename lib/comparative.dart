import 'package:app_doc/features/entity/photo.dart';
import 'package:app_doc/features/global/commun/header_widget.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:app_doc/features/global/commun/iconsapp_icons.dart';

class ComparativeScreen extends StatefulWidget {
  ComparativeScreen({super.key});

  @override
  _ComparativeScreenState createState() => _ComparativeScreenState();
}

class _ComparativeScreenState extends State<ComparativeScreen> {
  Photo? _image1;
  Photo? _image2;
  double _image2Offset = 0.5;
  bool orientation = true;

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
                                clipper: MycustomClippper(
                                    _image2Offset, orientation),
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
                      bottom: 0,
                      top: 0,
                      child: SfSliderTheme(
                          data: SfSliderThemeData(
                              inactiveTrackHeight: 0,
                              activeTrackHeight: 0,
                              thumbRadius: 17,
                              thumbColor: GlobalConfig.primaryColorApp),
                          child: RotatedBox(
                            quarterTurns: orientation ? 0 : 1,
                            child: SfSlider(
                              thumbIcon:
                                  Icon(Iconsapp.left_and_right_11wtecpnwuem),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: GlobalConfig.backgroundColor,
            height: GlobalConfig.heightPercentage(.35),
            width: GlobalConfig.width,
            child: ListView(
              children: <Widget>[
                Container(
                    margin:
                        EdgeInsets.only(left: GlobalConfig.widthPercentage(.1)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Iconsapp.resize_horizontal),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = true;
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Iconsapp.resize_vertical),
                              color: GlobalConfig.textColor,
                              onPressed: () {
                                setState(() {
                                  orientation = false;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
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
