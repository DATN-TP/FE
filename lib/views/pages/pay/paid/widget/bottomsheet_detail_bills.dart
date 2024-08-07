import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BottomsheetDetailBills extends StatelessWidget {
  const BottomsheetDetailBills({
    super.key,
    required this.apartment,
    required this.price,
    required this.owner,
    required this.electricity,
    required this.water,
    required this.previousPriceWater,
    required this.previousPriceElectricity,
  });

  final String apartment;
  final double price;
  final String owner;
  final double electricity;
  final double water;
  final double previousPriceWater;
  final double previousPriceElectricity;

  Widget _renderItemDetail({
    required Icon icon,
    required String title,
    required double price,
    required double previousPrice,
    required dynamic content,
  }) {
    //tính phần trăm chênh lệch giữa giá trị hiện tại và giá trị trước đó
    double percent = ((price - previousPrice) / previousPrice) * 100;
    //nếu content là số định dạng giá trị tiền về tiền việt nam xxx,xxx,xxx
    if (content is double) {
      content = content.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    }
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Row(
            children: [
              icon,
              Text(
                content.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              previousPrice == 0
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: price - previousPrice >= 0
                            ? price - previousPrice == 0
                                ? Colors.grey
                                : Colors.green
                            : Colors.red,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        //nếu giá trị phần trăm lớn hơn 0 thì thêm dấu + trước giá trị phần trăm
                        percent > 0
                            ? '+${percent.toStringAsFixed(2)}%'
                            : '${percent.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderChart(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 300,
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                'Bills',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            leftTitles: AxisTitles(),
          ),
          //chỉ hiện border phải với border dưới
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          barGroups: [
            // Tháng trước
            BarChartGroupData(
              //x  = 0 thì hiển thị tháng trước
              x: 0,

              barRods: [
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  toY: 120, // Tiền điện tháng trước
                  color: Colors.orange,
                  width: 40,
                ),
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  toY: 70, // Tiền nước tháng trước
                  color: Colors.blue,
                  width: 40,
                ),
              ],
            ),
            // Tháng hiện tại
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  toY: 100, // Tiền điện tháng hiện tại
                  color: Colors.orange,
                  width: 40,
                ),
                BarChartRodData(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  toY: 90, // Tiền nước tháng hiện tại
                  color: Colors.blue,
                  width: 40,
                ),
              ],
            ),
          ],
          alignment: BarChartAlignment.spaceAround,
          maxY: 130, // Đặt giá trị tối đa cho trục Y
        ),
      ),
    );
  }

  Widget _renderButtonBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {
          Navigator.pop(context);
        },
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _renderChart(context),
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: 200,
                  child: GridView.count(
                    childAspectRatio: 2,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    children: [
                      _renderItemDetail(
                        content: apartment,
                        price: 10000000,
                        previousPrice: 0,
                        icon: const Icon(
                          Icons.home,
                          size: 30,
                        ),
                        title: 'Home bills',
                      ),
                      _renderItemDetail(
                        content: electricity,
                        price: electricity,
                        previousPrice: previousPriceElectricity,
                        icon: const Icon(
                          Icons.electrical_services,
                          size: 30,
                        ),
                        title: 'Electricity',
                      ),
                      _renderItemDetail(
                        content: owner,
                        price: price,
                        previousPrice: 0,
                        icon: const Icon(
                          Icons.person,
                          size: 30,
                        ),
                        title: 'Owner',
                      ),
                      _renderItemDetail(
                        content: water,
                        price: water,
                        previousPrice: previousPriceWater,
                        icon: const Icon(
                          Icons.water_drop_sharp,
                          size: 30,
                        ),
                        title: 'Water',
                      ),
                    ],
                  ),
                ),
                _renderButtonBar(context),
              ],
            ),
          );
        });
  }
}
