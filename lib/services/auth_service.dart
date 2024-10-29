
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'api_service.dart';

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<User?> login(String username, String password, String FCMToken) async {
    try {
  final response = await apiService.post('/auth/login', {
    'username': username,
    'password': password,
    'role': 'resident',
    'FCMToken': FCMToken,
  });
  if (response['status'] == 'success') {
    final user = User.fromJson(response['user']);
    print(user);
    HiveProvider().saveUser(user);
    HiveProvider().saveApartmentId(user.apartments!.first);
    return user;
  } else {
    Fluttertoast.showToast(msg: "Tài khoản hoặc mật khẩu không chính xác");
    return null;
  }
} on Exception catch (e) {
  return null;
  }
  }

   //login với biometric
  Future<User?> loginBiometric(String data) async {
    try {
  final response = await apiService.post('/auth/login-biometric', {
    'data': data,
  });
  if (response['status'] == 'success') {
    final user = User.fromJson(response['user']);
    print(user);
    HiveProvider().saveUser(user);
    HiveProvider().saveApartmentId(user.apartments!.first);
    return user;
  } else {
    Fluttertoast.showToast(msg: "Thông tin sinh trắc học không chính xác");
    return null;
  }
} on Exception catch (e) {
  return null;
}
  }

  Future<Future> logout(String refreshToken) async {
    return apiService.post('/auth/logout', {
      'refreshToken': refreshToken,
    });
  }

  Future<Future> refreshToken(String token) async {
    return apiService.post('/auth/refresh', {
      'refreshToken': token,
    });
  }
}
