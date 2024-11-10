import 'dart:io';

import 'package:ResiEasy/models/request_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/request_service.dart';
import 'package:ResiEasy/services/upload_service.dart';
import 'package:flutter/material.dart';

class RequestViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isSuccess = false;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  String? get error => _error;

  UploadService uploadService = UploadService(ApiService());
  RequestService requestService = RequestService(ApiService());

  List<Request> listRequest =[];

  // Update loading state
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

  // Upload single image
  Future<void> uploadImage(File file) async {
    setLoading(true);
    try {
      final response = await uploadService.uploadImage(file);
      if (response != null) {
        // Handle success
        print("Response: $response");
      } else {
        setError('Failed to upload image');
      }
    } catch (e) {
      // Log error
      setError('Failed to upload image: $e');
    }
    clearLoading();
  }

  // Upload multiple images
  Future<List<String>> uploadMultipleImage(List<File> files) async {
    setLoading(true);
    List<String> urls = [];
    try {
      final response = await uploadService.uploadMultipleImage(files);
      if (response != null) {
        urls = response;
      } else {
        setError('Failed to upload images');
      }
    } catch (e) {
      setError('Failed to upload images: $e');
    }
    clearLoading();
    return urls;
  }

  // Create request
  Future<bool> createRequest(String type, String title, String description, String apartmentId, String userId, List<String> images) async {
    setLoading(true);
    try {
      final response = await requestService.createRequest(type, title, description, apartmentId, userId, images);
        setSuccess(true);
        if(response){
          getListRequestByApartment(apartmentId);
          notifyListeners();
        }
        return response;
      
    } catch (e) {
      setError('Failed to create request: $e');
    }
    clearLoading();
    return false;
  }

  //get list request of apartment
  Future<void> getListRequestByApartment(String id) async {
    setLoading(true);
    try {
      // Call API
      final response = await requestService.getListRequestByApartment(id);
      if (response.isNotEmpty) {
        //sort lại từ mới nhất đến cũ nhất
        response.sort((a, b) => b.createAt.compareTo(a.createAt));
        listRequest = response;
        notifyListeners();
      } else {
        setError('Failed to get list request');
      }
    } catch (e) {
      setError('Failed to get list request: $e');
    }
    clearLoading();
  }

  

  // Clear loading state
  void clearLoading() {
    _isLoading = false;
    notifyListeners();
  }

}
