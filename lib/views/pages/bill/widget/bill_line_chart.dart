import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:intl/intl.dart';  // Để định dạng ngày tháng

class BillLineChart extends StatelessWidget {
  final List<Bill> bills;

  BillLineChart({required this.bills});

  @override
  Widget build(BuildContext context) {
    // Check if the bills list is null or empty
    if (bills == null || bills.isEmpty) {
      return Center(child: Text('No data available'));
    }


    return SizedBox(
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  DateTime date = DateTime(2024, value.toInt(), 1);
                  return Text(DateFormat.MMM().format(date));
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: bills.map((bill) {
                // Ensure that createAt and amount are valid
                if (bill.createAt == null || bill.amount == null) {
                  return const FlSpot(0, 0);
                }
                double x = bill.createAt.month.toDouble();
                double y = bill.amount.toDouble();

                if (x.isNaN || x.isInfinite || y.isNaN || y.isInfinite) {
                  return const FlSpot(0, 0);
                }
                return FlSpot(x, y);
              }).toList(),
              isCurved: false,
              barWidth: 2,
              color: Colors.blue,
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
        
      ),
    );
  }
}