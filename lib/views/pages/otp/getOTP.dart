import 'package:datn/views/pages/otp/widget/background_otp.dart';
import 'package:datn/views/pages/otp/widget/imageSendOtp.dart';
import 'package:datn/views/pages/otp/widget/textFieldotp.dart';
import 'package:datn/views/pages/otp/widget/verifyButton.dart';
import 'package:flutter/material.dart';

class Getotp extends StatelessWidget {
  const Getotp({super.key});

  Widget _renderNotify() {
    return const Text(
      'We have sent an OTP to your phone',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            BackgroundOtp(),
            Align(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Imagesendotp(),
                    _renderNotify(),
                    const SizedBox(height: 20),
                    const Textfieldotp(),
                    const SizedBox(height: 20),
                    const Verifybutton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
