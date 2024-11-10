import 'dart:convert';
import 'dart:math';

import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/auth_service.dart';
import 'package:ResiEasy/services/biometric_service.dart';
import 'package:ResiEasy/views/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPageModel extends ChangeNotifier {
  final hiveProvider = HiveProvider();
  final BiometricService _biometricService = BiometricService(ApiService());
  final AuthService _authService = AuthService(ApiService());
  String _username = '';
  String _password = '';
  bool _isRemember = false;
  final AuthService authService = AuthService(ApiService());

  String get username => _username;
  String get password => _password;
  bool get isRemember => _isRemember;

  //loading 
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setIsRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  bool get checkBiometricEnable {
    final biometricData = hiveProvider.getBiometricData();

    if (biometricData?['userId'] != null && biometricData?['deviceId'] != null) {
      return true;
    }
    return false;
  }

  String get getUsernameBiometric {
    final biometricData = hiveProvider.getBiometricData();

    if (biometricData?['userId'] != null && biometricData?['deviceId'] != null) {
      return biometricData?['username'] ?? '';
    }
    return '';
  }
  String get getEmailBiometric {
    final biometricData = hiveProvider.getBiometricData();

    if (biometricData?['userId'] != null && biometricData?['deviceId'] != null) {
      return biometricData?['email'] ?? '';
    }
    return '';
  }


  Future<void> biometricLogin(context) async {
    final isAuthenticated = await _biometricService.authenticate();
    if (isAuthenticated) {
      final biometricData = hiveProvider.getBiometricData();
      if (biometricData?['userId'] != null &&
          biometricData?['deviceId'] != null) {
        biometricData?['FCMToken'] = HiveProvider().getFCMToken();
        final String encodedBiometricData = base64Encode(utf8.encode(jsonEncode(biometricData)));
       final response =  await _authService.loginBiometric(encodedBiometricData);
        if(response?.id != null){
          Navigator.pushNamed(context, Routes.home);
          notifyListeners();
        }
        else{
          Fluttertoast.showToast(msg: "Thông tin sinh trắc học không chính xác");
        }
      }
    }
  }

   void login(BuildContext context, String username, String password) async {
     setLoading(true);
     if (username.isEmpty || password.isEmpty) {
       setLoading(false);
       Fluttertoast.showToast(msg: "Vui lòng nhập mật khẩu");
       return;
     }
    final FCMToken = HiveProvider().getFCMToken();
    final response = await _authService.login(username, password, FCMToken);
    if (response?.id != null) {
      setLoading(false);
      Navigator.pushNamed(context, Routes.home);
    }
    else {
      setLoading(false);
      Fluttertoast.showToast(msg: "Tài khoản hoặc mật khẩu không chính xác");
    }
  }
}
