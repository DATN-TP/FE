import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/auth_service.dart';
import 'package:ResiEasy/views/pages/login/login_page_model.dart';
import 'package:ResiEasy/views/pages/login/widget/background_login.dart';
import 'package:ResiEasy/views/pages/login/widget/dialogCustom.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/views/pages/login/widget/otherMethodLogin.dart';
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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

  // ignore: unused_element
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => const Dialogcustom(),
        )) ??
        false;
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
          body: Consumer<LoginPageModel>(
            builder: (context, loginPageModel, child) {
              return Stack(
                children: [
                   Background(
                    point: 0.75,
                    color: ColorApp().cl1,
                    timer: 1500,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 50),
                                  child: Image.asset(
                                    'assets/images/logo_text_none_background.png',
                                    width: 600,
                                  ),
                                ),
                                const Logintitle(),
                                const SizedBox(height: 40),
                                !isBiometricEnable
                                    ? Column(
                                        children: [
                                          Username(
                                            controller: _usernameController,
                                          ),
                                          Password(
                                            controller: _passwordController,
                                          ),
                                          const SizedBox(height: 90),
                                          Loginbutton(
                                              onPressed: () =>
                                                  loginPageModel.login(
                                                      context,
                                                      _usernameController.text,
                                                      _passwordController.text)),
                                        ],
                                      )
                                    : _buildBiometricLoginButton(
                                        loginPageModel),
                                const Forgotpassbutton(),
                                // const SizedBox(height: 80),
                                // const Othermethodlogin(),
                                // const SizedBox(height: 30),
                                // const Signupbutton(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (loginPageModel.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildBiometricLoginButton(LoginPageModel loginPageModel) {
    final username = loginPageModel.getUsernameBiometric;
    // ignore: avoid_unnecessary_containers
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
        Password(
          controller: _passwordController,
        ),
        const SizedBox(height: 110),
        Loginbutton(
            onPressed: () => loginPageModel.login(
                context, username, _passwordController.text)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: () {},
              child: const Text(
                "Đăng nhập bằng tài khoản khác",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    ));
  }
}