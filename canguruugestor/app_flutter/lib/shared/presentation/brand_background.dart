import 'package:flutter/material.dart';
import '../../app/theme.dart';

/// Static gradients add warmth without image downloads, blur or animation.
class CanguruuBackground extends StatelessWidget {
  const CanguruuBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const BoxDecoration(
      color: CanguruuColors.offWhite,
      gradient: RadialGradient(
        center: Alignment(1.05, -0.85),
        radius: 1.15,
        colors: [Color(0xFFFFE98A), CanguruuColors.offWhite],
        stops: [0, 0.72],
      ),
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-1.1, 0.8),
          radius: 0.85,
          colors: [Color(0x66D8EDE2), Color(0x00E9DDBD)],
        ),
      ),
      child: child,
    ),
  );
}
