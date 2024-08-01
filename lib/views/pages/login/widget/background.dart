import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/widget/sShapeClipper.dart';
import 'dart:ui';

class Background extends StatelessWidget {
  final double point;
  final Color color;
  final double timer;

  const Background({
    Key? key,
    required this.point,
    required this.color,
    required this.timer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTopToBottom(
      durationMs: timer,
      child: ClipPath(
        clipper: SShapeClipper(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * point,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF5f1dfb),
                    color,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * point,
                color: Colors.black.withOpacity(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
