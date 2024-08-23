import 'dart:math';

import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<User> login(String username, String password) async {
    final response = await apiService.post('/auth/login', {
      'username': username,
      'password': password,
      'role': 'resident',
    });


    if (response != null) {
      final user = User.fromJson(response['user']);
      print(user);
      HiveProvider().saveUser(user);
      return user;
    } else {
      throw Exception('Failed to login');
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
