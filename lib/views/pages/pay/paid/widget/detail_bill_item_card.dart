import 'package:flutter/material.dart';

class DetailBillItemCard extends StatelessWidget {
  final List<Widget> row;

  const DetailBillItemCard({super.key, required this.row});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...row,
          ],
        ),
      ),
    );
  }
}