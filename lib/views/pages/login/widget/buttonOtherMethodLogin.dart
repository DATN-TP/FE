import 'package:flutter/material.dart';

class ButtonOtherMethodLogin extends StatelessWidget {
  // Constructor với đối số `icon` kiểu `IconData`
  const ButtonOtherMethodLogin({super.key, required this.icon});

  final IconData icon; // Biến `icon` được khai báo với kiểu `IconData`

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          onPressed: () {},
          child: Icon(icon), // Sử dụng biến `icon` đã được truyền vào
        ),
      ),
    );
  }
}
