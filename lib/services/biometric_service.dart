import 'package:ResiEasy/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  final ApiService apiService;
  BiometricService(this.apiService);



  Future<bool> authenticate() async {
    try {
      // Kiểm tra xem thiết bị có hỗ trợ sinh trắc học không
      final isAvailable = await _auth.canCheckBiometrics;
      if (!isAvailable) {
        Fluttertoast.showToast(msg: 'Biometric authentication is not available');
        return false;
      }
      final biometrics = await _auth.getAvailableBiometrics();
      if (biometrics.isEmpty) {
        Fluttertoast.showToast(msg: 'Please set up biometric authentication before using this feature');
        return false;
      }

      // Thực hiện xác thực sinh trắc học
      final isAuthenticated = await _auth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      return isAuthenticated;
    } catch (e) {
      print('Error during biometric authentication: $e');
      return false;
    }
  }

  //gọi API đăng ký sinh trắc học
  Future<bool> registerBiometric(String data) async {
    final isAuthenticated = await authenticate();
    if (isAuthenticated) {
      final response = await apiService.post('/auth/register-biometric', {
        'data': data,
      });
      if (response['status'] == "success") {
        Fluttertoast.showToast(msg: 'Đăng ký thành công');
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Lỗi');
        return false;
      }
    }
    return false;
  }
}
