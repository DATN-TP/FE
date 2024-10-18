import 'package:ResiEasy/models/bill_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillItem extends StatelessWidget {
  final Bill bill;
  final VoidCallback onTap;
  const BillItem({super.key, required this.bill, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String monthYear = DateFormat('MM/yyyy').format(bill.createAt??DateTime.now());
    String amount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(bill.total);

    Color colorStatus;
    Color colorBackgroundStatus;
    Text status;
    if (bill.status == 'paid') {
      status = const Text("Đã thanh toán", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
      colorStatus = Colors.green;
      colorBackgroundStatus = Colors.green.shade100;
    } else {
      status = const Text("Chờ thanh toán", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold));
      colorStatus = Colors.orange;
      colorBackgroundStatus = Colors.orange.shade100;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/icon/Logo.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hóa đơn tháng $monthYear',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tổng: $amount",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: colorBackgroundStatus,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: status,
                        ),
              
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}
