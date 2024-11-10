
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/models/vehicle_model.dart';
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

  Future<List<Vehicle>> getListVehicleByApartment(String id) async {
    final response = await apiService.get('/vehicle/get-vehicle-by-apartment/$id');
    if (response != null) {
      return response.map<Vehicle>((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }

//get list apartment
  Future<List<Apartment>> getListApartment (String id) async {
    final response = await apiService.get('/user/get-apartment-of-user/$id');
    if (response != null) {
      return response.map<Apartment>((json) => Apartment.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }
}
