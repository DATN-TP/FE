import 'package:datn/data/hive/hive_provider.dart';
import 'package:datn/services/biometric_service.dart';
import 'package:datn/views/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends ChangeNotifier {
  final hiveProvider = HiveProvider();
  final BiometricService _biometricService = BiometricService();
  String _username = '';
  String _password = '';
  bool _isRemember = false;

  String get username => _username;
  String get password => _password;
  bool get isRemember => _isRemember;

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

    if (biometricData?['username'] != null && biometricData?['token'] != null) {
      return true;
    }
    return false;
  }

  String get getUsernameBiometric {
    final biometricData = hiveProvider.getBiometricData();

    if (biometricData?['username'] != null && biometricData?['token'] != null) {
      return biometricData?['username'] ?? '';
    }
    return '';
  }

  Future<void> biometricLogin(context) async {
    final isAuthenticated = await _biometricService.authenticate();
    if (isAuthenticated) {
      final biometricData = hiveProvider.getBiometricData();
      if (biometricData?['username'] != null &&
          biometricData?['token'] != null) {
        _username = biometricData?['username'] ?? '';
        _password = biometricData?['token'] ?? '';
        Navigator.pushNamed(context, Routes.home);
        notifyListeners();
      }
    }
  }
}
