import 'package:flutter/material.dart';

class BackgroundSignup extends StatelessWidget {
  const BackgroundSignup(
      {super.key,
      required this.color,
      required this.position,
      required this.opacity});

  final Color color;
  final Alignment position;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //tâm top left

        gradient: RadialGradient(
          colors: [
            const Color(0xffac3bff),
            color,
          ],
          center: Alignment.topRight,
          radius: 1.5,
          focalRadius: 0.5,
        ),
      ),
    );
  }
}
