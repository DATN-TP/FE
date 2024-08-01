import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:flutter/material.dart';

class Logintitle extends StatelessWidget {
  const Logintitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlideTopToBottom(
      durationMs: 1500,
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
