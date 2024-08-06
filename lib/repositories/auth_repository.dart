import 'package:datn/models/user_model.dart';
import 'package:datn/services/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository(this.authService);

  Future<User> login(String username, String password) async {
    final response = await authService.login(username, password);
   
    return response;
  }

}

