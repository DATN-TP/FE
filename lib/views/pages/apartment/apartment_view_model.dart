import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/services/apartment_service.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:flutter/material.dart';

class ApartmentViewModel with ChangeNotifier {
  final ApartmentService _apartmentService = ApartmentService(ApiService());
  Apartment? _apartment;
  bool _isLoading = false;
  String? _error;


  Apartment? get apartment => _apartment;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchApartment(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _apartment = await _apartmentService.getDetailApartment(id);
      _error = null;
    } catch (e) {
      _error = 'Failed to load apartment: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
