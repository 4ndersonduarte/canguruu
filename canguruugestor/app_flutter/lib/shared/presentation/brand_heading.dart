import 'package:flutter/material.dart';
import '../../app/theme.dart';

class CanguruuHeading extends StatelessWidget {
  const CanguruuHeading(this.text, {super.key, this.style});
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text, style: style ?? Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 3),
      const SizedBox(
        width: 104,
        height: 7,
        child: CustomPaint(painter: _Marker()),
      ),
    ],
  );
}

class _Marker extends CustomPainter {
  const _Marker();
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * .4)
      ..quadraticBezierTo(size.width * .48, 0, size.width, size.height * .1)
      ..lineTo(size.width * .96, size.height * .65)
      ..quadraticBezierTo(size.width * .4, size.height * .55, 2, size.height);
    canvas.drawPath(path..close(), Paint()..color = CanguruuColors.yellow);
  }

  @override
  bool shouldRepaint(_Marker oldDelegate) => false;
}
