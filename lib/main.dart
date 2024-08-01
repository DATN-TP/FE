import 'package:datn/views/routes/routes.dart';
import 'package:flutter/material.dart';
import './views/pages/login/login.dart';

void main() {
  runApp(
    const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Login(),
    ),
  );
}
