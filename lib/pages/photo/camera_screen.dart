
import 'dart:io';
import 'package:app_doc/features/global/accelerometer.dart';
import 'package:app_doc/features/global/camera_widgets.dart';
import 'package:app_doc/features/global/commun/iconsapp_icons.dart';
import 'package:app_doc/features/global/global_config.dart';
import 'package:app_doc/generated/l10n.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CameraScreen extends StatefulWidget {
  final dynamic camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

enum Option {zoom,brightness}
class _CameraScreenState extends State<CameraScreen> {
  RotationAngleDetector? _rotationAngleDetector;
  CameraController? _cameraController;
  double _offsetSlider = 0.0;
  double exposure = 0.0;
  double zoom = 1.0;
  String _category = 'G';
  bool _photo = true;
  double _valueRotation = 0.0;
  final PageController _pageController = PageController();
  Option optionView = Option.zoom;

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
      ResolutionPreset.medium,
    );
    _cameraController!.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        _cameraController!.setZoomLevel(2.5);
      });
    });
    _offsetSlider = 2.5;
  }

  @override
  void dispose() {
    _rotationAngleDetector!.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  Widget buildCategory(context, title, icons, category) {
    return Container(
        margin:
            EdgeInsets.symmetric(horizontal: GlobalConfig.widthPercentage(.1)),
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
                child: Row(
                  children: [
                    for (final icon in icons)
                      IconButton(
                        icon: Icon(icon),
                        color: GlobalConfig.alternativeComplementaryColorApp,
                        highlightColor: GlobalConfig.secundaryColorApp,
                        iconSize: GlobalConfig.heightPercentage(0.06),
                        onPressed: () {
                          setState(() {
                            _photo = false;
                            _category = category;
                          });
                          _showTemplate(icons.indexOf(icon));
                        },
                      ),
                  ],
                )),
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
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: cameraWidget(_valueRotation, _cameraController, context,
                  _category, _pageController, _photo, parameters['photo']),
            ),
            _options(),
            optionView == Option.zoom ?
              _slider(icon:Icons.zoom_in_rounded , min: 1)
            : _slider(icon: Icons.brightness_6_outlined ,min: -2,max: 2),
            FloatingActionButton(
              heroTag: "camera",
              backgroundColor: GlobalConfig.primaryColorApp,
              child: Icon(
                  color: GlobalConfig.backgroundColor,
                  Icons.camera_alt_outlined,
                  size: GlobalConfig.heightPercentage(0.05)),
              onPressed: () async {
                final image = await _cameraController!.takePicture();
                final croppedFile = await _cropImage(image);
                Navigator.pushNamed(context, '/preview-photo', arguments: {
                  'image': File(croppedFile!.path),
                  'pacient': parameters['pacient']
                });

                // Guardar la foto con la grilla aplicada
              },
            ),
            Container(
              color: GlobalConfig.backgroundColor,
              height: GlobalConfig.heightPercentage(.20),
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
    );
  }

  Widget _options() {
    return SegmentedButton<Option>(
      segments: const <ButtonSegment<Option>>[
        ButtonSegment<Option>(
            value: Option.zoom,
            label: Text('Zoom'),
            icon: Icon(Icons.zoom_in_rounded)),
        ButtonSegment<Option>(
            value: Option.brightness,
            label: Text('Brightness'),
            icon: Icon(Icons.brightness_6_outlined)),
      ],
      selected: <Option>{optionView},
      onSelectionChanged: (Set<Option> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          if(newSelection.first == Option.zoom){
            _offsetSlider = zoom;
          }else{
            _offsetSlider = exposure;
          }
          optionView = newSelection.first;
        });
      },
    );
  }

  Widget _slider({IconData? icon, double min = 0, double max = 5}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,children: [Icon(icon),SfSliderTheme(
        data: SfSliderThemeData(
            thumbRadius: 17, thumbColor: GlobalConfig.primaryColorApp),
        child: RotatedBox(
          quarterTurns: 0,
          child: SfSlider(
            enableTooltip: true, interval: 1, stepSize: 0.1, showDividers: true,
            dividerShape: SfDividerShape(),
            thumbIcon: Icon(icon), //Icon(Icons.zoom_in),
            value: _offsetSlider,
            min: min,
            max: max,
            onChanged: (dynamic changed) {
              setState(() {
                if (changed % 1 == 0) {
                  HapticFeedback.heavyImpact();
                }

                _offsetSlider = changed;
                if (min < 0) {
                  _cameraController!.setExposureOffset(changed);
                  exposure = changed;
                } else {
                  _cameraController!.setZoomLevel(changed);
                  zoom = changed;
                }
              });
            },
          ),
        ))]) ;
  }

  Future<CroppedFile?> _cropImage(image) async {
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        sourcePath: image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            aspectRatioLockDimensionSwapEnabled: true,
            hidesNavigationBar: true,
            aspectRatioLockEnabled: true,
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: const CropperSize(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );

      if (croppedFile != null) {
        return croppedFile;
      }
    }
    return null;
  }
}
