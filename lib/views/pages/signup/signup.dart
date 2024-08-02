import 'package:datn/views/animations/slideBottomToTop.dart';
import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:datn/views/pages/signup/widget/background_signup.dart';
import 'package:datn/views/pages/signup/widget/confirmpass.dart';
import 'package:datn/views/pages/signup/widget/loginbutton.dart';
import 'package:datn/views/pages/signup/widget/password.dart';
import 'package:datn/views/pages/signup/widget/signupButton.dart';
import 'package:datn/views/pages/signup/widget/signupTitle.dart';
import 'package:datn/views/pages/signup/widget/username.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SlideTopToBottom(
              durationMs: 1000,
              child: BackgroundSignup(
                color: Color(0xFF5f1dfb),
                position: Alignment.bottomRight,
                opacity: 0.1,
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SlideTopToBottom(
                durationMs: 1000,
                child: Signuptitle(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: SlideBottomToTop(
                  durationMs: 1000,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      backgroundBlendMode: BlendMode.overlay,
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      border: Border.all(
                        color: Colors.black,
                        width: 9,
                      ),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Username(),
                        Password(),
                        Confirmpass(),
                        SignupButton(),
                        Loginbutton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
