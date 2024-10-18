import 'package:ResiEasy/models/base_response.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/services/api_service.dart';

class BillService {
  final ApiService apiService;
  BillService(this.apiService);

  Future<BaseResponse> getBill(String apartmentId, int page, int limit, String search) async {
    final response = await apiService.get('/bill/get-bills-by-apartment/$apartmentId/$page/$limit/$search');
    return BaseResponse.fromJson(response);
    }
}