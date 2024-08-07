import 'package:datn/views/animations/slideBottomToTop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../routes/routes.dart';

class Signupbutton extends StatelessWidget {
  const Signupbutton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideBottomToTop(
      durationMs: 1500,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 8,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6f24fd),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, Routes.signup);
          },
          child: Text(
            'txt_Signup'.tr(),
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
