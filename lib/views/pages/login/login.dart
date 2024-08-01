import 'package:datn/views/pages/login/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/widget/otherMethodLogin.dart';
import './widget/userName.dart';
import './widget/password.dart';
import './widget/loginTitle.dart';
import './widget/loginButton.dart';
import './widget/forgotpassButton.dart';
import './widget/signUpbutton.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(
            point: 0.75,
            color: Color.fromARGB(255, 179, 159, 176),
          ),
          const Background(
            point: 0.73,
            color: Color(0xFFac3bff),
          ),
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logintitle(),
                    SizedBox(height: 40),
                    Username(),
                    Password(),
                    SizedBox(height: 40),
                    Loginbutton(),
                    Forgotpassbutton(),
                    SizedBox(height: 80),
                    Othermethodlogin(),
                    SizedBox(height: 30),
                    Signupbutton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
