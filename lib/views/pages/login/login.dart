import 'package:datn/views/pages/login/login_page_model.dart';
import 'package:datn/views/pages/login/widget/background.dart';
import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/widget/otherMethodLogin.dart';
import 'package:provider/provider.dart';
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
    //reset textfield và unfocus khi chuyển qua màn hình khác
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  //khi quay lại màn hình login thì reset textfield và unfocus
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ChangeNotifierProvider(
        create: (_) => LoginPageModel(),
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
                  child: Consumer<LoginPageModel>(
                    builder: (context, loginPageModel, child) {
                      final isBiometricEnable =
                          loginPageModel.checkBiometricEnable;
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Logintitle(),
                            const SizedBox(height: 40),
                            !isBiometricEnable
                                ? const Column(
                                    children: [
                                      Username(),
                                      Password(),
                                      SizedBox(height: 40),
                                      Loginbutton(),
                                    ],
                                  )
                                : _buildBiometricLoginButton(loginPageModel),
                            const Forgotpassbutton(),
                            const SizedBox(height: 80),
                            const Othermethodlogin(),
                            const SizedBox(height: 30),
                            const Signupbutton(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBiometricLoginButton(LoginPageModel loginPageModel) {
    final username = loginPageModel.getUsernameBiometric;
    return Container(
        child: Column(
      children: [
        Text(
          'Xin chào, $username',
          style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 20),
        const Password(),
        const SizedBox(height: 20),
        const Loginbutton(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              
            },
            child: 
            const Text("Đăng nhập bằng tài khoản khác", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),)
          ),
        )
      ],
    ));
  }
}
