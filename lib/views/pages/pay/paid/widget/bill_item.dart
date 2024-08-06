import 'package:datn/views/pages/pay/paid/widget/custom_shimmer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BillItem extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  bool status;
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final price;
  String expired;

  BillItem({
    super.key,
    required this.id,
    required this.status,
    required this.title,
    required this.price,
    required this.expired,
  });

  Future<void> _loadData() async {
    // Giả lập quá trình tải dữ liệu
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomShimmer();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '101',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            expired,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      'Tổng: ' + price + ' VNĐ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    status
                        ? InkWell(
                            onTap: () {},
                            child: const Text(
                              'Chi tiết >',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {},
                            child: const Text(
                              'Thanh toán >',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
