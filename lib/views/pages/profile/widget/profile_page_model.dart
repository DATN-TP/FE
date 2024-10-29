import 'dart:convert';
import 'dart:io';

import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/biometric_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

class ProfilePageModel extends ChangeNotifier {
  bool _isBiometricEnabled = false;
  final BiometricService _biometricService = BiometricService(ApiService());
  final hiveProvider = HiveProvider();
  bool get isBiometricEnabled => _isBiometricEnabled;
  ProfilePageModel() {
    checkBiometricEnable();
  }
  
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return "UnknownDevice";
  }

  void switchBiometric(bool value) async {
   
    _isBiometricEnabled = value;
    if (value) {
       String deviceId = await _getId() ?? "";
      final Map<String, String> biometricData = {
          'email': hiveProvider.getUser()?.email ?? "",
          'username': hiveProvider.getUser()?.username ?? "",
          'userId': hiveProvider.getUser()?.id ?? "",
          'deviceId': deviceId,
        };
        final String encodedBiometricData = base64Encode(utf8.encode(jsonEncode(biometricData)));
      final isAuthenticated = await _biometricService.registerBiometric(encodedBiometricData);
      if (isAuthenticated) {
        hiveProvider.saveBiometricData(biometricData);
        notifyListeners();
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

  void checkBiometricEnable() {
    Map<String, String>? biometricData = hiveProvider.getBiometricData();
    if (biometricData?['userId'] != null && biometricData?['deviceId'] != null) {
      _isBiometricEnabled = true;
    } else {
      _isBiometricEnabled = false;
    }
    notifyListeners();
  }
}
