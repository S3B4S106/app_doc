import 'package:app_doc/features/global/global_config.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

Animation<double> opacityFacial = AlwaysStoppedAnimation(.6);

final Map<String, List<Widget>> _allTemplates = {
  "G": [Container(), grid3X3(), grid4X4()],
  "A": [
    Image.asset(
      "assets/1.png",
      opacity: opacityFacial,
    ),
    Image.asset(
      "assets/2.png",
      opacity: opacityFacial,
    ),
    Image.asset(
      "assets/3.png",
      opacity: opacityFacial,
    ),
    Image.asset(
      "assets/4.png",
      opacity: opacityFacial,
    ),
    Image.asset(
      "assets/5.png",
      opacity: opacityFacial,
    ),
    Image.asset(
      "assets/6.png",
      opacity: opacityFacial,
    ),
  ]
};

Widget cameraWidget(accelerometer, cameraController, context, templates,
    pageController, ghost, photo,
    {opacity = .0}) {
  return Stack(
    children: [
      Container(
        child: PageView(
          controller: pageController,
          children: ghost && photo != null
              ? [
                  Opacity(
                      opacity: opacity,
                      child: Stack(
                        children: [
                          Image.network(
                            photo.ruta,
                          ),
                          labelAccelerometer(double.parse(photo.angle),
                              top: .11),
                        ],
                      )),
                ]
              : _allTemplates[templates]!,
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            left: GlobalConfig.widthPercentage(.03),
            top: GlobalConfig.heightPercentage(.03)),
        child: FloatingActionButton(
            heroTag: "close",
            mini: true,
            backgroundColor: Color.fromARGB(111, 213, 209, 209),
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      labelAccelerometer(accelerometer)
    ],
  );
}

Widget labelAccelerometer(accelerometer, {left = .82, top = .03}) {
  return Container(
    margin: EdgeInsets.only(
        left: GlobalConfig.widthPercentage(left),
        top: GlobalConfig.heightPercentage(top)),
    child: ClipOval(
        child: TextButton(
      onPressed: () {},
      child: Text(
        '${accelerometer.truncate()}°',
        style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
          backgroundColor: accelerometer.truncate() != 0
              ? MaterialStatePropertyAll(Color.fromARGB(111, 213, 209, 209))
              : MaterialStatePropertyAll(Colors.blue)),
    )),
  );
}

Widget grid3X3() {
  return LayoutGrid(
    columnSizes: [1.fr, 1.fr, 1.fr],
    rowSizes: [1.fr, 1.fr, 1.fr],
    children: [
      Container(),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      Container(),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      Container(),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      Container(),
    ],
  );
}

Widget grid4X4() {
  Path customPath = Path()..lineTo(0, 150);
  return LayoutGrid(
    columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
    rowSizes: [1.fr, 1.fr, 1.fr, 1.fr],
    children: [
      Container(),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      Container(),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
      DottedBorder(
        customPath: (size) => customPath,
        dashPattern: [8],
        color: Colors.white,
        strokeWidth: 1,
        child: Container(),
      ),
    ],
  );
}
