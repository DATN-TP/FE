import 'dart:math';

import 'package:datn/data/hive/hive_provider.dart';
import 'package:datn/services/biometric_service.dart';
import 'package:flutter/material.dart';

class ProfilePageModel extends ChangeNotifier {
  bool _isBiometricEnabled = false;
  final BiometricService _biometricService = BiometricService();
  final hiveProvider = HiveProvider();
  bool get isBiometricEnabled => _isBiometricEnabled;

  void switchBiometric(bool value) async {
      _isBiometricEnabled = value;
      if (value) {
      final isAuthenticated = await _biometricService.authenticate();
      if (isAuthenticated) {
        final Map<String, String> biometricData = {
          'username': "admin",
          'token': "token",
        };
        hiveProvider.saveBiometricData(biometricData);
      } else {
        _isBiometricEnabled = false;
        notifyListeners();
       
      }
    } else {
      // Nếu tắt sinh trắc học, xóa dữ liệu
      hiveProvider.saveBiometricData({});
    }
      notifyListeners();
      }
}