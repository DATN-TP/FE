import 'package:flutter/material.dart';

class Textfieldotp extends StatelessWidget {
  const Textfieldotp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: 'Enter OTP',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
