import 'dart:io';

import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/upload_service.dart';
import 'package:flutter/material.dart';

class RequestViewModel  extends ChangeNotifier{
  bool _isLoading = false;
  String? _error;

    bool get isLoading => _isLoading;
  String? get error => _error;

  UploadService uploadService = UploadService(ApiService());

  //upload image 
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
    notifyListeners();
  }

  void clearLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void clearErrorLoading() {
    _error = null;
    _isLoading = false;
    notifyListeners();
  }

  //upload image to server
  Future<void> uploadImage(File file) async {
    setLoading(true);
    try {
      final response = await uploadService.uploadImage(file);
      if (response != null) {
        print("respone đây:: $response");

      } else {
        setError('Failed to upload image');
      }
    } catch (e) {
      //error
      setError('Failed to upload image');
    }
    clearLoading();
  }

  //upload multiple image to server
  Future<void> uploadMultipleImage(List<File> files) async {
    setLoading(true);
    try {
      final response = await uploadService.uploadMultipleImage(files);
      if (response != null) {
        print("respone đây:: $response");
      } else {
        setError('Failed to upload image');
      }
    } catch (e) {
      //error
      setError('Failed to upload image');
    }
    clearLoading();
  }


}