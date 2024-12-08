import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/auth_service.dart';
import 'package:ResiEasy/views/pages/login/login_page_model.dart';
import 'package:ResiEasy/views/pages/login/widget/background_login.dart';
import 'package:ResiEasy/views/pages/login/widget/dialogCustom.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/views/pages/login/widget/otherMethodLogin.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  LoginPageModel loginViewModel = LoginPageModel();
  bool isBiometricEnable = false;

  final AuthService _authService = AuthService(ApiService());

  Future<void> _login(LoginPageModel loginPageModel) async {
    loginPageModel.isLoading = true;
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập đầy đủ thông tin");
      return;
    }
    final FCMToken = HiveProvider().getFCMToken();
    final userRes = await _authService.login(username, password, FCMToken);
    if (userRes?.id != null) {
      loginPageModel.isLoading = false;
      Navigator.pushNamed(context, '/home');
    } else {
      loginPageModel.isLoading = false;
      Fluttertoast.showToast(msg: "Tài khoản hoặc mật khẩu không chính xác");
    }
  }

  @override
  void initState() {
    super.initState();
    isBiometricEnable = loginViewModel.checkBiometricEnable;
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
                    color: Colors.green.shade200,
                    timer: 1500,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Consumer<LoginPageModel>(
                        builder: (context, loginPageModel, child) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 50),
                                  child: Image.asset(
                                    'assets/images/logo_text_none_background.png',
                                    width: 600,
                                  ),
                                ),
                                !isBiometricEnable
                                    ? Column(
                                        children: [
                                          const Logintitle(),
                                          const SizedBox(height: 40),
                                          Username(
                                            controller: _usernameController,
                                          ),
                                          Password(
                                            controller: _passwordController,
                                            isBiometric: isBiometricEnable,
                                          ),
                                          const SizedBox(height: 90),
                                          Loginbutton(
                                              onPressed: () =>
                                                  loginPageModel.login(
                                                      context,
                                                      _usernameController.text,
                                                      _passwordController
                                                          .text)),
                                          if(loginPageModel.checkBiometricEnable)
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    isBiometricEnable =
                                                        !isBiometricEnable;
                                                  });
                                                },
                                                child: const Text(
                                                  "Đăng nhập bằng sinh trắc học",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
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
    final email = loginPageModel.getEmailBiometric;
    // ignore: avoid_unnecessary_containers
    return Container(
        child: Column(
      children: [
        const SizedBox(height: 40),
        Text(
          'Xin chào, $username',
          style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
          softWrap: true,
          maxLines: 2,
        ),
        const SizedBox(height: 20),
        Password(
          controller: _passwordController,
          isBiometric: isBiometricEnable,
        ),
        const SizedBox(height: 168),
        Loginbutton(
            onPressed: () =>
                loginPageModel.login(context, email, _passwordController.text)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: () {
                setState(() {
                  isBiometricEnable = !isBiometricEnable;
                });
              },
              child:  Text(
                "Đăng nhập bằng tài khoản khác",
                style: TextStyle(
                    color: ColorApp().cl1,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    ));
  }
}
