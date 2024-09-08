import 'package:ResiEasy/views/pages/pay/paid/widget/detail_bill_item_card.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BottomsheetDetailBills extends StatelessWidget {
  const BottomsheetDetailBills(
      {super.key,
      required this.apartment,
      required this.price,
      required this.owner,
      required this.electricity,
      required this.water,
      required this.previousPriceWater,
      required this.previousPriceElectricity,
      required this.status});

  final String apartment;
  final double price;
  final String owner;
  final double electricity;
  final double water;
  final double previousPriceWater;
  final double previousPriceElectricity;
  final bool status;

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
    return Expanded(
      flex: 1,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              icon,
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  content.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
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
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: Colors.black,
          width: 2,
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
    return status == false
        ? Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ),
          )
        : SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            //blue close button
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Close',
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
                Flexible(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            DetailBillItemCard(
                              row: [
                                Row(
                                  children: [
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.home,
                                        color: Colors.black,
                                      ),
                                      title: 'Apartment',
                                      price: 0,
                                      previousPrice: 0,
                                      content: apartment,
                                    ),
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      title: 'Owner',
                                      price: 0,
                                      previousPrice: 0,
                                      content: owner,
                                    )
                                  ],
                                )
                              ],
                            ),
                            DetailBillItemCard(
                              row: [
                                Row(
                                  children: [
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.electrical_services,
                                        color: Colors.black,
                                      ),
                                      title: 'Electricity',
                                      price: electricity,
                                      previousPrice: previousPriceElectricity,
                                      content: electricity,
                                    ),
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.water,
                                        color: Colors.black,
                                      ),
                                      title: 'Water',
                                      price: water,
                                      previousPrice: previousPriceWater,
                                      content: water,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.car_crash,
                                        color: Colors.black,
                                      ),
                                      title: 'Gửi xe',
                                      price: electricity,
                                      previousPrice: previousPriceElectricity,
                                      content: electricity,
                                    ),
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.water,
                                        color: Colors.black,
                                      ),
                                      title: 'Internet',
                                      price: water,
                                      previousPrice: previousPriceWater,
                                      content: water,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.car_crash,
                                        color: Colors.black,
                                      ),
                                      title: 'Gửi xe',
                                      price: electricity,
                                      previousPrice: previousPriceElectricity,
                                      content: electricity,
                                    ),
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.water,
                                        color: Colors.black,
                                      ),
                                      title: 'Internet',
                                      price: water,
                                      previousPrice: previousPriceWater,
                                      content: water,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            DetailBillItemCard(
                              row: [
                                Row(
                                  children: [
                                    _renderItemDetail(
                                      icon: const Icon(
                                        Icons.electrical_services,
                                        color: Colors.black,
                                      ),
                                      title: 'Tổng hóa đơn',
                                      price: electricity,
                                      previousPrice: previousPriceElectricity,
                                      content: electricity,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            _renderChart(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _renderButtonBar(context),
              ],
            ),
          );
        });
  }
}
