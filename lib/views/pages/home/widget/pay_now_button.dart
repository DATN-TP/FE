import 'package:flutter/material.dart';

class PayNowButton extends StatelessWidget {
  const PayNowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/billsPay');
      },
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width / 2 - 20,
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.payment, color: Colors.orange),
              SizedBox(width: 5),
              Text('Thanh toán ngay'),
            ],
          ),
        ),
      ),
    );
  }
}
