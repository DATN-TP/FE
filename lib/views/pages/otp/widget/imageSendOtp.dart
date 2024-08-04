import 'package:flutter/material.dart';

class Imagesendotp extends StatelessWidget {
  const Imagesendotp({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.asset(
        fit: BoxFit.cover,
        'assets/images/sentotp.png',
      ),
    );
  }
}
