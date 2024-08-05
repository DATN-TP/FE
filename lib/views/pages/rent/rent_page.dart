import 'package:flutter/material.dart';

class RentPage extends StatelessWidget {
  const RentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Rent Page',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    ));
  }
}
