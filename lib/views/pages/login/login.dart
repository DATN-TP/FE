import 'package:datn/views/pages/login/widget/background_login.dart';
import 'package:datn/views/pages/login/widget/dialogCustom.dart';
import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/widget/otherMethodLogin.dart';
import './widget/userName.dart';
import './widget/password.dart';
import './widget/loginTitle.dart';
import './widget/loginButton.dart';
import './widget/forgotpassButton.dart';
import './widget/signUpbutton.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => Dialogcustom(),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
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
        ),
      ),
    );
  }
}
