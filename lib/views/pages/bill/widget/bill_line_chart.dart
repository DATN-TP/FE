import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:intl/intl.dart'; // Để định dạng ngày tháng

class BillLineChart extends StatelessWidget {
  final List<Bill> bills;

  const BillLineChart({super.key, required this.bills});

  @override
  Widget build(BuildContext context) {
    // Check if the bills list is null or empty
    if (bills.isEmpty) {
      return const Center(child: Text('No data available'));
    }
// Chỉ lấy 6 tháng gần nhất
    bills.sort((a, b) => a.createAt!.compareTo(b.createAt!));
    List<Bill> data =
        bills.length > 6 ? bills.sublist(bills.length - 6) : bills;

    List<Bill> dataChart = List.from(data);
    if (dataChart.length < 6) {
      int lg = 6 - dataChart.length;
      for (int i = 0; i < lg; i++) {
        dataChart.insert(
            0,
            Bill(
                createAt:
                    DateTime.now().subtract(Duration(days: 30 * (lg - i))),
                total: 0));
      }
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
          gridData: const FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: dataChart.map((bill) {
                // Ensure that createAt and amount are valid
                if (bill.total == null) {
                  return const FlSpot(0, 0);
                }
                double x = bill.createAt!.month.toDouble();
                double y = bill.total!;

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
