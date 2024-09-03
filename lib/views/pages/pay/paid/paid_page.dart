import 'package:ResiEasy/data/data/list_bills.dart';
import 'package:ResiEasy/views/pages/pay/paid/widget/bill_item.dart';
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
        body: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green[500],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.white,
                      fillColor: WidgetStateProperty.all(Colors.white),
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                    const Text('Paid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.red[500],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Radio(
                      activeColor: Colors.white,
                      fillColor: WidgetStateProperty.all(Colors.white),
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ),
                    const Text(
                      'Unpaid',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
                previousPriceElectricity: ListBills.bills.indexOf(bill) - 1 < 0
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
    ));
  }
}
