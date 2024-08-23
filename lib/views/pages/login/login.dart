
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
  final AuthService _authService =
AuthService(ApiService());
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  Future<void> _login(LoginPageModel loginPageModel) async {
    // final username = _usernameController.text;
    // final password = _passwordController.text;

    const username = "huuphuoc.2632@gmail.com";
    const password = "12345";

    final user_res = await _authService.login(username, password);
    Navigator.pushNamed(context, '/home');
  }

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
                                ? Column(
                                    children: [
                                      Username(
                                        controller: _usernameController,
                                      ),
                                      Password(
                                        controller: _passwordController,
                                      ),
                                      const SizedBox(height: 40),
                                      Loginbutton(
                                          onPressed: () =>
                                              _login(loginPageModel)),
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
        const SizedBox(height: 20),
        Loginbutton(onPressed: () => _login(loginPageModel)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
              onTap: () {},
              child: const Text(
                "Đăng nhập bằng tài khoản khác",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              )),
        )
      ],
    ));
  }
}
