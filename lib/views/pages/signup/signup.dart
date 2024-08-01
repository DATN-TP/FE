import 'package:datn/views/pages/login/widget/background.dart';
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
            const Background(
              point: 0.75,
              color: Color.fromARGB(255, 179, 159, 176),
              timer: 1300,
            ),
            const Background(
              point: 0.73,
              color: Color(0xFFac3bff),
              timer: 1500,
            ),
            Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Signuptitle(),
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
          ],
        ),
      ),
    );
  }
}
