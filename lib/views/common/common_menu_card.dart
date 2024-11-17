import 'package:flutter/material.dart';

class CommonMenuCard extends StatelessWidget {
  final Icon icon;
  final Text title;
  final VoidCallback onPressed;
  final int? index;

  const CommonMenuCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed,
      this.index});

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
    switch (index) {
      case 0:
        borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), topRight: Radius.circular(10));
        break;
      case 1:
        borderRadius = const BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10), topLeft: Radius.circular(10));
        break;
      case 2:
        borderRadius = const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
        break;
      case 3:
         borderRadius = const BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10));
      default:
    }
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.grey,
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: 
            Column(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 20),
                title
              ],
            ),
      ),
    );
  }
}
