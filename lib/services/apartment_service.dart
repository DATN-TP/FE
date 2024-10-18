import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/services/api_service.dart';

class ApartmentService {
  final ApiService apiService;

  ApartmentService(this.apiService);

  Future<Apartment> getDetailApartment(String id) async {
    final response = await apiService.get('/apartment/get-detail-apartment/$id');

    if (response != null) {
      return Apartment.fromJson(response);
    } else {
      throw Exception('Failed to get detail apartment');
    }
  }

  //lấy tên chủ hộ
  Future<String> getOwnerName(String id) async {
    final response = await apiService.get('/apartment/get-owner/$id');
    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to get owner name');
    }
  }
}
