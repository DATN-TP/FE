import 'package:datn/views/pages/pay/paid/paid_page.dart';
import 'package:datn/views/pages/pay/paid/detail_page.dart';
import 'package:flutter/material.dart';

class BillsPay extends StatelessWidget {
  const BillsPay({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff712BBC), Color(0xff7AA0D5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Bills'),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    const RentPage(),
                    DetailPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
