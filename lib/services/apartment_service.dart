import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class ApartmentService {
  final ApiService apiService;

  ApartmentService(this.apiService);

  Future<Apartment> getDetailApartment(String id) async {
    final response = await apiService.get('/apartment/get-detail-apartment/$id');

    if (response != null) {
      dev.log('responseaaa: ${Apartment.fromJson(response)}');
      return Apartment.fromJson(response);
    } else {
      throw Exception('Failed to get detail apartment');
    }
  }
}
