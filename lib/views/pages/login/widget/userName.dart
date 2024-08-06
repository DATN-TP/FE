import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  final TextEditingController controller;
  const Username({super.key, required this.controller});

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
        child: TextField(
          controller: controller,
          decoration:const InputDecoration(
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
