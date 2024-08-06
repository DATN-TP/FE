import 'package:flutter/material.dart';

class ChartWater extends StatelessWidget {
  final List<int> data;

  const ChartWater({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${index + 1}'),
              Container(
                width: 20,
                height: data[index].toDouble() / 10,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900,
                      Colors.blue.shade800,
                      Colors.blue.shade500,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
