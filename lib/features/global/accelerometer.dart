import 'dart:async';
import 'dart:math' as math;
import 'package:sensors/sensors.dart';

class RotationAngleDetector {
  double _rotationAngle = 0.0;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  Function(double rotationAngle) onRotationAngleUpdate;

  RotationAngleDetector({required this.onRotationAngleUpdate}) {
    _accelerometerSubscription =
        accelerometerEvents.listen((event) => _updateRotationAngle(event));
  }

  void dispose() {
    _accelerometerSubscription?.cancel();
  }

  void _updateRotationAngle(AccelerometerEvent event) {
    double x = event.x;
    double y = event.y;
    double z = event.z;

    // Calculate inclination angle using arctangent and convert to degrees
    double inclinationAngle = math.atan2(z, y) * 180 / math.pi;

    if (_rotationAngle.truncate() != inclinationAngle.truncate()) {
      _rotationAngle = inclinationAngle;

      // Invert the rotation angle to start from zero when vertical, increasing backward
    }

    onRotationAngleUpdate(_rotationAngle);
  }

  double get currentRotationAngle => _rotationAngle;
}
