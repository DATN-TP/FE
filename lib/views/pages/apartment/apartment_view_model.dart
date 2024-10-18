import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/services/apartment_service.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/user_service.dart';
import 'package:flutter/material.dart';

class ApartmentViewModel with ChangeNotifier {
  final ApartmentService _apartmentService = ApartmentService(ApiService());
  final UserService userService = UserService(ApiService());
  Apartment? _apartment;
  bool _isLoading = false;
  String? _error;
  String? _ownerName;


  Apartment? get apartment => _apartment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get ownerName => _ownerName;

  List<Apartment> listApartment = [];

  

  Future<void> fetchApartment(String id, String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _apartment = await _apartmentService.getDetailApartment(id);
      listApartment = await userService.getListApartment(userId);
      _ownerName = await _apartmentService.getOwnerName(id);
      _error = null;
    } catch (e) {
      _ownerName = null;
      _error = 'Failed to load apartment: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
