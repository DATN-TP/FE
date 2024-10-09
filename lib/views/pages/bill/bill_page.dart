import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/data/list_bills.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/views/pages/bill/bill_view_model.dart';
import 'package:ResiEasy/views/pages/bill/detail/bill_detail_page.dart';
import 'package:ResiEasy/views/pages/bill/widget/bill_line_chart.dart';
import 'package:ResiEasy/views/pages/bill/widget/bill_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillPage extends StatefulWidget {
  final String apartmentId;
  final String userId;
  const BillPage({super.key, required this.apartmentId, required this.userId});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BillViewModel()..getBill( widget.apartmentId, 1, 20, ""),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'txt_listBill'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorApp().cl1,
          titleSpacing: 0,
        ),
        body: 
       Consumer<BillViewModel>(
      builder: (context, billViewModel, child) {
          return SafeArea(
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  _buildChart(billViewModel),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'txt_listBill'.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  _buildListBill(),
                ],
              ),
            ),
          );
      }
        ),
      ),
    );
  }

  Widget _buildListBill() {
    return Consumer<BillViewModel>(
      builder: (context, billViewModel, child) {
        // if (billViewModel.isLoading) {
        //   return Center(child: CircularProgressIndicator());
        // }
        billViewModel.ListBills.sort((a, b) => b.createAt!.compareTo(a.createAt!));
        return Expanded(
          child: ListView.builder(
            itemCount: billViewModel.ListBills.length,
            itemBuilder: (context, index) {
              return BillItem(
                bill: billViewModel.ListBills[index],
                onTap: () => {
                  
                  Navigator.of(
                    context
                  ).push(
                    MaterialPageRoute(
                      builder: (context) => const BillDetailPage(),
                      settings:
                      RouteSettings(arguments: billViewModel.ListBills[index]),
                    ),
                  ),
                },
              );  
            },
          ),
        );
      },
    );
  }

  Widget _buildChart(BillViewModel billViewModel) {
    try {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        height: 300,
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: BillLineChart(bills: billViewModel.ListBills),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  'Biểu đồ giá trị hóa đơn (6 tháng)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Center(
        child: Text('Error loading chart: $e'),
      );
    }
  }
}