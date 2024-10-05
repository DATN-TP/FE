import 'package:ResiEasy/models/vehicle_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/user_service.dart';
import 'package:flutter/material.dart';

class VehicleViewModel extends ChangeNotifier{

  final UserService userService = UserService(ApiService());

  List<Vehicle> _listVehicle = [];

  List<Vehicle> get listVehicle => _listVehicle;

   bool _isLoading = false;
  String? _error;

    bool get isLoading => _isLoading;
  String? get error => _error;

   Future<void> getListVehicleByApartment(String id) async {
       _isLoading = true;
    final response = await userService.getListVehicleByApartment(id);
    _listVehicle = response;
    _error = null;
    _isLoading = false;
    notifyListeners();
    }

    



}