import 'package:datn/data/hive/hive_provider.dart';
import 'package:datn/views/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import './views/pages/login/login.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<Map<dynamic, dynamic>>(HiveProvider.HIVE_BIOMETRIC_BOX);
  runApp(
   EasyLocalization(
    supportedLocales: const [
      Locale('en', 'US'),
      Locale('vi', 'VN'),
    ],
    path: 'assets/translations',
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/',
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        home: const Login(),
      );
  }
}
