import 'package:datn/data/hive/hive_provider.dart';
import 'package:datn/models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<User> login(String username, String password) async {
   final response = await apiService.post('/auth/login', {
      'username': username,
      'password': password,
    });
    if (response['user'] != null) {
      HiveProvider().saveUser(User.fromJson(response['user']));
      return User.fromJson(response['user']);
    } else {
      throw Exception('Failed to login');
    }
  }

  // Future<Map<String, dynamic>> register(String email, String password) async {
  //   final response = await apiService.post('/auth/register', {
  //     'email': email,
  //     'password': password,
  //   });
  //   return response;
  // }

  Future<Map<String, dynamic>> logout(String refreshToken) async {
    final response = await apiService.post('/auth/logout', {
      'refreshToken': refreshToken,
    });
    return response;
  }

  Future<Map<String, dynamic>> refreshToken(String token) async {
    final response = await apiService.post('/auth/refresh', {
      'refreshToken': token,
    });
    return response;
  }
}
