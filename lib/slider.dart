import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final Function(double) onChanged;

  const CustomSlider({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _dragStartValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) => _dragStartValue = widget.value,
      onHorizontalDragUpdate: (details) {
        final delta = details.delta.dx / MediaQuery.of(context).size.width;
        final newValue = widget.value + delta;
        widget.onChanged(newValue.clamp(0.0, 1.0));
      },
      child: FractionalTranslation(
        translation: Offset(widget.value, 0.0),
        child: Icon(Icons.slideshow_outlined),
      ),
    );
  }
}

class _CustomSliderPainter extends CustomPainter {
  final double value;

  const _CustomSliderPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0;

    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomSliderPainter oldDelegate) =>
      value != oldDelegate.value;
}
