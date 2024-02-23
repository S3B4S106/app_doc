import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

final Map<String, List<Widget>> _allTemplates = {
  "G": [Container(), grid3X3(), grid4X4()],
  "A": [Container(), Image.asset("assets/Contorno.png"), Container()]
};

Widget cameraWidget(cameraController, context, templates, pageController) {
  return CameraPreview(cameraController!,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2 +
                (MediaQuery.of(context).size.height * 0.15),
            width: MediaQuery.of(context).size.width,
            child: PageView(
              controller: pageController,
              children: _allTemplates[templates]!,
            ),
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
