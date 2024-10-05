import 'package:ResiEasy/services/api_service.dart';

class RequestService {
  final ApiService apiService;

  RequestService(this.apiService);

  Future<void> createRequest(String type,String title, String description, String apartmentId, String userId, List<String> images) async {
    final response = await apiService.post('/request/add-request', {
      'title': title,
      'description': description,
      'apartment': apartmentId,
      'user': userId,
      'image': images,
      'type': type,
    });

    if (response != null) {
      return response;
    } else {
      throw Exception('Failed to create request');
    }
  }


}