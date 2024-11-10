import 'package:ResiEasy/models/base_response.dart';
import 'package:ResiEasy/models/notification_model.dart';
import 'package:ResiEasy/services/api_service.dart';

class NotificationsService {
   final ApiService apiService;

  NotificationsService(this.apiService);

  //get list notification by user
  Future<BaseResponse> getListNotificationByUser(String apartmentId, String id, int page, int limit) async {
    final response = await apiService.get('/noti/getNotifications', queryParameters: {
      'apartmentId': apartmentId,
      'userId': id,
      'page': page,
      'limit': limit,
    });
    if (response != null) {
      return BaseResponse.fromJson(response);
    } else {
      throw Exception('Unexpected response format');
    }
    }
    //đọc thông báo
    Future<bool> readNotification(String id) async {
    final response = await apiService.put('/noti/readNotification/$id', {});
    if (response != null) {
      return true;
    } else {
      return false;      
    }

    }
}