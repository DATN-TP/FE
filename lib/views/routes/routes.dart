import 'package:ResiEasy/views/pages/bill/bill_page.dart';
import 'package:ResiEasy/views/pages/home/home.dart';
import 'package:ResiEasy/views/pages/otp/getOTP.dart';
import 'package:ResiEasy/views/pages/pay/bills_pay.dart';
import 'package:ResiEasy/views/pages/request/detail/request_detail_page.dart';
import 'package:ResiEasy/views/pages/request/request_page.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/views/pages/login/login.dart';
import 'package:ResiEasy/views/pages/signup/signup.dart';

class Routes {
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';
  static const String getotp = '/getotp';
  static const String billsPay = '/billsPay';
  static const String requestPage = '/requestPage';
  static const String billPage = '/billPage';
  static const String requestDetail = '/requestDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => const Signup());
      case login:
        return MaterialPageRoute(builder: (_) => const Login());
      case home:
        return MaterialPageRoute(builder: (_) => const Home());
      case getotp:
        return MaterialPageRoute(builder: (_) => const Getotp());
      case billsPay:
        return MaterialPageRoute(builder: (_) => const BillsPay());
      case requestPage:
        return MaterialPageRoute(builder: (_) => const RequestPage());
      case billPage:
        return MaterialPageRoute(builder: (_) => const BillPage());
      case requestDetail:
        return MaterialPageRoute(builder: (_) => const RequestDetailPage());
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
