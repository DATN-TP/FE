import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/services/api_service.dart';

class BillService {
  final ApiService apiService;
  BillService(this.apiService);

  Future<List<Bill>> getBill(String apartmentId, int page, int limit, String search) async {
    final response = await apiService.get('/bill/get-bills-by-apartment/$apartmentId/$page/$limit/$search');
    if (response != null) {
      return response.map<Bill>((json) => Bill.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get bill');
    }
  }
}