import 'package:hive/hive.dart';

class HiveProvider {
  static const String HIVE_BIOMETRIC_BOX = 'HIVE_BIOMETRIC_BOX';
  
  Box<Map<dynamic, dynamic>>? biometricBox;

  HiveProvider() {
    biometricBox = Hive.box<Map<dynamic, dynamic>>(HIVE_BIOMETRIC_BOX);
  }

  Future<void> initPref() async {
    biometricBox = await Hive.openBox<Map<dynamic, dynamic>>(HIVE_BIOMETRIC_BOX);
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
}
