import 'package:ResiEasy/models/user_model.dart';
import 'api_service.dart';

class UserService {
  final ApiService apiService;

  UserService(this.apiService);

  // Future<User> getUser(int userId) async {
  //   final response = await apiService.get('/users/$userId');
  //   return User.fromJson(response);
  // }

  Future<User> createUser(User user) async {
    final response = await apiService.post('/users', user.toJson());
    return User.fromJson(response);
  }

  Future<User> updateUser(int userId, User user) async {
    final response = await apiService.put('/users/$userId', user.toJson());
    return User.fromJson(response);
  }

  Future<void> deleteUser(int userId) async {
    await apiService.delete('/users/$userId');
  }
}
