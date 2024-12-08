import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/animations/slideTopToBottom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Loginbutton extends StatelessWidget {
  final VoidCallback onPressed;
  const Loginbutton({super.key, required this.onPressed});

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
            backgroundColor: ColorApp().cl1,
            elevation: 15,
            shadowColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            'txt_login'.tr(),
            style: const TextStyle(
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
