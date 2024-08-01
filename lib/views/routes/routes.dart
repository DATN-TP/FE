import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/login.dart';
import 'package:datn/views/pages/signup/signup.dart';

class Routes {
  static const String signup = 'package:datn/views/pages/signup/signup.dart';
  static const String login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => const Signup());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
