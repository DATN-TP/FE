import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/vnpayService.dart';
import 'package:flutter/material.dart';


class BillViewModel extends ChangeNotifier {

  final Vnpayservice vnpayservice = Vnpayservice(ApiService());

  Future<void> createPayment() async {
    try {
      await vnpayservice.createPaymentUrl();
      notifyListeners();
    } catch (e) {
      print('Error creating payment URL: $e');
    }
  }
}