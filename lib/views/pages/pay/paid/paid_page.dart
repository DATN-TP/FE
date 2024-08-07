import 'package:datn/data/data/list_bills.dart';
import 'package:datn/views/pages/pay/paid/widget/bill_item.dart';
import 'package:flutter/material.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
                const Text('Paid'),
                Radio(
                  value: 2,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value!;
                    });
                  },
                ),
                const Text('Unpaid'),
              ],
            ),
            for (var bill in ListBills.bills)
              if ((_selectedValue == 1 &&
                      (bill as Map<String, dynamic>)['status'] == true) ||
                  (_selectedValue == 2 &&
                      (bill as Map<String, dynamic>)['status'] == false))
                BillItem(
                  water: (bill)['water'],
                  // previousPriceWater bằng giá trị tiền nước của phần tử có index - 1 nếu index < 0 thì bằng 0
                  previousPriceWater: ListBills.bills.indexOf(bill) - 1 < 0
                      ? 0
                      : (ListBills.bills[ListBills.bills.indexOf(bill) - 1]
                          as Map<String, dynamic>)['water'],
                  previousPriceElectricity:
                      ListBills.bills.indexOf(bill) - 1 < 0
                          ? 0
                          : (ListBills.bills[ListBills.bills.indexOf(bill) - 1]
                              as Map<String, dynamic>)['electricity'],
                  electricity: (bill)['electricity'],
                  owner: (bill)['owner'],
                  expired: (bill)['expired'],
                  price: (bill)['price'],
                  title: (bill)['title'],
                  status: (bill)['status'],
                  id: (bill)['id'],
                  apartment: (bill)['apartment'],
                ),
          ],
        ),
      ),
    ));
  }
}
