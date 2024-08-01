import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:flutter/material.dart';

class Forgotpassbutton extends StatelessWidget {
  const Forgotpassbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideTopToBottom(
      durationMs: 1500,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          onPressed: () {},
          child: const Text('Forgot Password?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
