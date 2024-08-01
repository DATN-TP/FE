import 'package:hive/hive.dart';

class HiveProvider {
  static const String HIVE_BIOMETRIC_BOX = 'HIVE_BIOMETRIC_BOX';
  
  Box<Map<String, String>>? biometricBox;
  HiveProvider() {
    biometricBox = Hive.box<Map<String, String>>(HIVE_BIOMETRIC_BOX);
  }
  Future<void> initPref() async {
    biometricBox = await Hive.openBox<Map<String, String>>(HIVE_BIOMETRIC_BOX);
    return;
  }
  void saveBiometricData(Map<String, String> data) {
    biometricBox!.put('biometric', data);
  }
  Map<String, String>? getBiometricData() {
    return biometricBox!.get('biometric');
  }
}