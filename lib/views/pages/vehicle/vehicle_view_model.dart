import 'package:ResiEasy/models/vehicle_model.dart';
import 'package:flutter/material.dart';

class VehicleViewModel extends ChangeNotifier{

  List<Vehicle> _listVehicle = [];

  List<Vehicle> get listVehicle => _listVehicle;

   bool _isLoading = false;
  String? _error;

    bool get isLoading => _isLoading;
  String? get error => _error;

}