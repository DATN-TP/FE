import 'package:ResiEasy/views/animations/slideTopToBottom.dart';
import 'package:easy_localization/easy_localization.dart';
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
          child: Text('${'txt_ForgotPassword'.tr()}?',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )),
        ),
      ),
    );
  }
}
