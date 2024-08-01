import 'package:datn/views/animations/slideBottomToTop.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'buttonOtherMethodLogin.dart';

class Othermethodlogin extends StatelessWidget {
  const Othermethodlogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SlideBottomToTop(
      durationMs: 1500,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonOtherMethodLogin(icon: FontAwesomeIcons.facebook),
            ButtonOtherMethodLogin(icon: FontAwesomeIcons.google),
            ButtonOtherMethodLogin(icon: FontAwesomeIcons.twitter),
          ],
        ),
      ),
    );
  }
}
