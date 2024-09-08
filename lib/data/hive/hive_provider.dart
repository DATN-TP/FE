import 'dart:convert';

import 'package:ResiEasy/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveProvider {
  static const String HIVE_BIOMETRIC_BOX = 'HIVE_BIOMETRIC_BOX';
  static const String HIVE_USER_BOX = 'HIVE_USER_BOX';
  
  Box<Map<dynamic, dynamic>>? biometricBox;
  Box<String>? userBox;

  HiveProvider() {
    biometricBox = Hive.box<Map<dynamic, dynamic>>(HIVE_BIOMETRIC_BOX);
    userBox = Hive.box<String>(HIVE_USER_BOX);
  }

  Future<void> initPref() async {
    biometricBox = await Hive.openBox<Map<dynamic, dynamic>>(HIVE_BIOMETRIC_BOX);
    userBox = await Hive.openBox<String>(HIVE_USER_BOX);
    return;
  }

  void saveBiometricData(Map<String, String> data) {
    biometricBox!.put('biometric', data);
  }

  Map<String, String>? getBiometricData() {
    var data = biometricBox!.get('biometric');
    if (data != null) {
      return Map<String, String>.from(data);
    }
    return null;
  }
  void saveUser(User? user) {
    if (user == null) {
      userBox?.put(HIVE_USER_BOX, "");
      return;
    }
    userBox?.put(HIVE_USER_BOX, json.encode(user.toJson()));
  }
  User? getUser() {

    final str = userBox?.get(HIVE_USER_BOX);
    print("str: $str");
    if (str == null || str.isEmpty) return null;
    return User.fromJson(json.decode(str));
  }

  String getFCMToken() {
    return userBox?.get('fcm_token') ?? '';
  } 

  void saveFCMToken(String token) {
    userBox?.put('fcm_token', token);
  }

}
