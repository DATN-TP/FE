import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/auth_service.dart';
import 'package:ResiEasy/services/biometric_service.dart';
import 'package:ResiEasy/views/routes/routes.dart';
import 'package:flutter/material.dart';

class LoginPageModel extends ChangeNotifier {
  final hiveProvider = HiveProvider();
  final BiometricService _biometricService = BiometricService();
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

   void login(BuildContext context, String username, String password) async {
   setLoading(true);
    // final username = _usernameController.text;
    // final password = _passwordController.text;

    const username = "huuphuoc.2632@gmail.com";
    const password = "12345";
    
    await _authService.login(username, password);
    setLoading(false);
    Navigator.pushNamed(context, Routes.home);
  }
}
