import 'package:app_doc/features/global/commun/transversals.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

final Map<String, List<Widget>> _allTemplates = {
  "G": [Container(), grid3X3(), grid4X4()],
  "A": [
    Image.asset(
      "assets/1.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
    Image.asset(
      "assets/2.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
    Image.asset(
      "assets/3.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
    Image.asset(
      "assets/4.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
    Image.asset(
      "assets/5.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
    Image.asset(
      "assets/6.png",
      opacity: AlwaysStoppedAnimation(.25),
    ),
  ]
};

Widget cameraWidget(accelerometer, cameraController, context, templates,
    pageController, ghost, photo) {
  return CameraPreview(cameraController!,
      child: Stack(
        children: [
          Container(
            child: PageView(
              controller: pageController,
              children: _allTemplates[templates]!,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalConfig.widthPercentage(.05),
                top: GlobalConfig.heightPercentage(.05)),
            child: FloatingActionButton(
                heroTag: "close",
                mini: true,
                backgroundColor: Color.fromARGB(111, 213, 209, 209),
                child: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          Container(
            margin: EdgeInsets.only(
                left: GlobalConfig.widthPercentage(.7),
                top: GlobalConfig.heightPercentage(.05)),
            child: ClipOval(
                child: TextButton(
              onPressed: () {},
              child: Text(
                '${accelerometer.truncate()}°',
                style: TextStyle(color: Colors.black),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(111, 213, 209, 209))),
            )),
          ),
        ],
      ));
}

Widget grid3X3() {
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
