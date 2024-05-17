import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Rotation Angle',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _rotationAngle = 0.0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((event) => _updateRotationAngle(event));
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription?.cancel();
  }

  void _updateRotationAngle(AccelerometerEvent event) {
    double x = event.x;
    double y = event.y;
    double z = event.z;

    // Calculate inclination angle using arctangent and convert to degrees
    double inclinationAngle = math.atan2(z, y) * 180 / math.pi;

    if (_rotationAngle.truncate() != inclinationAngle.truncate()) {
      setState(() {
        _rotationAngle = inclinationAngle;

        // Invert the rotation angle to start from zero when vertical, increasing backward
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device Rotation Angle'),
      ),
      body: Center(
        child: Text(
          'Rotation Angle: ${_rotationAngle.truncate()}°',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
