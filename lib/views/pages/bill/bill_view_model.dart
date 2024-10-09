import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/bill_service.dart';
import 'package:ResiEasy/services/vnpayService.dart';
import 'package:flutter/material.dart';


class BillViewModel extends ChangeNotifier {

  final Vnpayservice vnpayservice = Vnpayservice(ApiService());
  final BillService billS = BillService(ApiService());

  List<Bill> ListBills = [];

  Future<void> createPayment(int amount) async {
    try {
      await vnpayservice.createPaymentUrl(amount);
      notifyListeners();
    } catch (e) {
      print('Error creating payment URL: $e');
    }
  }

  Future<void> getBill(String apartmentId, int page, int limit, String search) async {
    try {
      ListBills = await billS.getBill(apartmentId, page, limit, search);
      ListBills.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      notifyListeners();
    } catch (e) {
      print('Error getting bill: $e');
    }
  }


}