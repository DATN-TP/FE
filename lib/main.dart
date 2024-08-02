import 'package:datn/data/hive/hive_provider.dart';
import 'package:datn/views/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import './views/pages/login/login.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<Map<dynamic, dynamic>>(HiveProvider.HIVE_BIOMETRIC_BOX);
  runApp(
    const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}
