import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VehicleItem extends StatelessWidget {
  const VehicleItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image(
            image: Image.network(
                    'https://res.cloudinary.com/ds3qf4ip3/image/upload/v1725797995/honda-sh-160i-2024-2-004451_yyn8uz.jpg')
                .image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
           const Expanded(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Honda SH 160i',
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    '63P1-99999',
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),

                  Text(
                    "Huỳnh Hữu Phước",
                    style:
                        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
