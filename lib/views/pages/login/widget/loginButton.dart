import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:datn/views/routes/routes.dart';
import 'package:flutter/material.dart';

class Loginbutton extends StatelessWidget {
  const Loginbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideTopToBottom(
      durationMs: 1500,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: const Color(0xFF6f24fd),
            elevation: 15,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.home);
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
