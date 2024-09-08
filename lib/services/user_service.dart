
import 'package:ResiEasy/models/user_model.dart';
import 'api_service.dart';

class UserService {
  final ApiService apiService;

  UserService(this.apiService);

  //get user by apartment
Future<List<User>> getListUserByApartment(String id) async {
  final response = await apiService.get('/user/get-list-user-by-apartment/$id');

  if (response != null) {
      return response['data'].map<User>((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  } 
}
