import 'package:datn/views/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:datn/views/pages/login/login.dart';
import 'package:datn/views/pages/signup/signup.dart';

class Routes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => const Signup());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
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
