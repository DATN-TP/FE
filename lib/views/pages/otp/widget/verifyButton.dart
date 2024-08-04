import 'package:datn/views/pages/otp/widget/dialogSucessfull.dart';
import 'package:flutter/material.dart';

class Verifybutton extends StatelessWidget {
  const Verifybutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          colors: [
            Color(0xff712BBC),
            Colors.white,
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          transform: GradientRotation(3.14 / 2),
        ),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Dialogsucessfull().showAnimatedDialog(context);
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          });
        },
        child: const Center(
          heightFactor: 2,
          child: Text(
            'Verify',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
