import 'package:ResiEasy/models/request_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RequestItem extends StatelessWidget {
  final Request request;
  const RequestItem({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
              children: [
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      request.title,
                      style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildStatusRequest(),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios, color: Colors.grey[300],),
            ),
          ],
        ),
    );
  }
  
_buildStatusRequest() {
  Color statusBackgroundColor;
  Color statusColor;
  String statusText;

  switch (request.status) {
    case -1:
      statusBackgroundColor = Colors.red.shade100;
      statusColor = Colors.red;
      statusText = "txt_rejected".tr();
      break;
    case 0:
      statusBackgroundColor = Colors.grey.shade100;
      statusColor = Colors.grey;
      statusText = "txt_sent".tr();
      break;
    case 1:
      statusBackgroundColor = Colors.blue.shade100;
      statusColor = Colors.blue;
      statusText = "txt_received".tr();
      break;
    case 2:
      statusBackgroundColor = Colors.orange.shade100;
      statusColor = Colors.orange;
      statusText = "txt_pending".tr();
      break;
    case 3:
      statusBackgroundColor = Colors.green.shade100;
      statusColor = Colors.green;
      statusText = "txt_approved".tr();
      break;
    default:
      statusBackgroundColor = Colors.grey.shade100;
      statusColor = Colors.grey;
      statusText = "Unknown";
      break;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      color: statusBackgroundColor,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: statusColor),
    ),
    child: Text(
      statusText,
      style: TextStyle(
        fontSize: 12,
        color: statusColor,
      ),
    ),
  );
}

}