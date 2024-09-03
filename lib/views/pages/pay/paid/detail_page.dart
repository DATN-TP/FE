import 'package:ResiEasy/views/pages/pay/paid/widget/chart_water.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  final data12MonthElectricPay = [
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    1000,
    1100,
    1200,
  ];

  Widget _buildChart(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.bottomCenter,
      child: ChartWater(
        data: data12MonthElectricPay,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: const Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(5, 10),
                    ),
                  ],
                ),
                child: _buildChart(context),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: const Center(
                  child: Text(
                    '12 Month Electric Pay',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
