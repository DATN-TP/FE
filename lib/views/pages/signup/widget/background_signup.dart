import 'package:flutter/material.dart';

class BackgroundSignup extends StatelessWidget {
  BackgroundSignup(
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
        gradient: LinearGradient(colors: [
          color.withOpacity(opacity),
          color,
        ], begin: position),
      ),
    );
  }
}
