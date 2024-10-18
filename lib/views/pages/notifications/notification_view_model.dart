import 'dart:math';
import 'dart:developer' as dev;

import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/models/notification_model.dart';

class NotificationViewModel extends ChangeNotifier{
   bool _isLoading = false;
   bool _isSuccess = false;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get error => _error;

  int totalPage = 0;

  List<NotificationModel> listNotification =[];



  NotificationsService notificationsService = NotificationsService(ApiService());

  //get list notification by user

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearAll() {
    _error = null;
    _isLoading = false;
    _isSuccess = false;
    notifyListeners();
  }

  void setSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  //get list notification by user
  Future<void> getListNotificationByUser(String apartmentId,String id, int page, int limit) async {
    setLoading(true);
    try {
      final response = await notificationsService.getListNotificationByUser(apartmentId, id, page, limit);
      dev.log('Response: $response');
      listNotification = response.data?.data.map<NotificationModel>((json) => NotificationModel.fromJson(json)).toList();
      totalPage = response.data?.pagination?.totalPages ?? 0;
      clearError();
      setSuccess(true);
        } catch (e) {
      setError('Failed to get list notification');
    }
    setLoading(false);
  }

  //đọc thông báo
  Future<void> readNotification(String id) async {
    setLoading(true);
    try {
      final response = await notificationsService.readNotification(id);
      if (response) {
        // Handle success
        print("Response: $response");
      } else {
        setError('Failed to read notification');
      }
    } catch (e) {
      // Log error
      setError('Failed to read notification: $e');
    }
    clearAll();
  }

}