import 'package:ResiEasy/models/request_model.dart';
import 'package:ResiEasy/services/api_service.dart';

class RequestService {
  final ApiService apiService;

  RequestService(this.apiService);

  Future<bool> createRequest(String title, String description, String apartmentId, String userId, List<String> images) async {
    final response = await apiService.post('/request/add-request', {
      'title': title,
      'description': description,
      'apartment': apartmentId,
      'user': userId,
      'image': images,
    });

    if (response != null) {
      return true;
    } else {
      return false;      
    }
    
  }
  //get request by apartment
  Future<List<Request>> getListRequestByApartment(String id) async {
    final response = await apiService.get('/request/get-request-by-apartment/$id');
    if (response != null) {
      return response.map<Request>((json) => Request.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  }


}