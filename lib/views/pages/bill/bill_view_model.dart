import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/services/api_service.dart';
import 'package:ResiEasy/services/bill_service.dart';
import 'package:ResiEasy/services/vnpayService.dart';
import 'package:flutter/material.dart';


class BillViewModel extends ChangeNotifier {

  final Vnpayservice vnpayservice = Vnpayservice(ApiService());
  final BillService billS = BillService(ApiService());

  bool isLoading = false;
  String? error;

  int currentPage = 1;
  int totalPage = 0;

  List<Bill> ListBills = [];

  Bill bill = Bill();

  Future<void> createPayment(int amount, String billId, String paymentBy, String apartmentId) async {
    try {
      await vnpayservice.createPaymentUrl(amount, billId, paymentBy, apartmentId);
      notifyListeners();
    } catch (e) {
      print('Error creating payment URL: $e');
    }
  }

  Future<void> getBill(String apartmentId, int page, int limit, String search) async {
    try {
      isLoading = true;
      final response = await billS.getBill(apartmentId, page, limit, search);
      if(page == 1){
        ListBills = response.data!.data!.map<Bill>((json) => Bill.fromJson(json)).toList();
        currentPage = 2;
      }
      else {
        ListBills.addAll(response.data!.data!.map<Bill>((json) => Bill.fromJson(json)).toList());
        currentPage++;
      }
      totalPage = response.data!.pagination!.totalPages ?? 0;
      ListBills.sort((a, b) => b.createAt!.compareTo(a.createAt!));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error getting bill: $e');
    }
  }

  Future<void> getBillById(String id) async {
    try {
      isLoading = true;
      bill = await billS.getBillById(id);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print('Error getting bill by id: $e');
    }
  }


}