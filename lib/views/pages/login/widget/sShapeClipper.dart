import 'package:flutter/material.dart';

class SShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80); // Bắt đầu đường dẫn từ góc dưới bên trái
    path.cubicTo(
      size.width / 4, size.height, // Điểm kiểm soát thứ nhất
      3 * size.width / 4, size.height - 160, // Điểm kiểm soát thứ hai
      size.width, size.height - 80, // Điểm cuối cùng
    );

    path.lineTo(size.width, 0); // Đóng đường dẫn
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
