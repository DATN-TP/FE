import 'package:ResiEasy/models/vehicle_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VehicleItem extends StatelessWidget {
  final Vehicle vehicle;
  const VehicleItem({super.key, required this.vehicle});

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
                    vehicle.image != null && vehicle.image!.isNotEmpty ? vehicle.image![0] : "https://res.cloudinary.com/ds3qf4ip3/image/upload/v1728108015/yblclbsgcqtwgtqld4uu.jpg",)
                .image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
           Expanded(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    vehicle.name!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    vehicle.licensePlate!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),

                  Text(
                    vehicle.brand!,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  Text(
                    vehicle.owner?.username??"",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
