import 'package:ResiEasy/models/vehicle_model.dart';
import 'package:flutter/material.dart';

class VehicleViewModel extends ChangeNotifier{

  final List<Vehicle> _listVehicle = [];

  List<Vehicle> get listVehicle => _listVehicle;

   final bool _isLoading = false;
  String? _error;

    bool get isLoading => _isLoading;
  String? get error => _error;

}