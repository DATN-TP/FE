import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  const Username({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideTopToBottom(
      durationMs: 1500,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(
          screenWidth * 0.05,
          10,
          screenWidth * 0.05,
          10,
        ),
        child: const TextField(
          decoration: InputDecoration(
            suffix: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            labelText: 'Username',
          ),
        ),
      ),
    );
  }
}
