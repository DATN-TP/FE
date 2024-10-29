import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/notification_model.dart';
import 'package:ResiEasy/views/pages/bill/bill_page.dart';
import 'package:ResiEasy/views/pages/home/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  const NotificationItem({super.key, required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        _goToDetail(notification, context);
      },
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: notification.isRead == true ? ColorApp().white: ColorApp().grey300,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: ColorApp().grey300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                 Icon(
                  notification.isRead == true ? Icons.notifications : Icons.notifications_active,
                  color: notification.isRead == true ? Colors.grey : ColorApp().black,
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title ?? "",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: notification.isRead == true ? Colors.black54 : Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 120, // Adjust the width as needed
                      child: Text(
                        notification.content ?? "",
                        style:  TextStyle(
                          fontSize: 12,
                          color: notification.isRead == true ? Colors.grey : Colors.black,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              Text(
                _calTimeOfNotification(notification.createdAt),
                style:  TextStyle(
                  fontSize: 12,
                  color: notification.isRead == true ? Colors.grey : Colors.black,
                ),
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
              ],
            )
          ],
        ),
      ),
    );
  }
  String _calTimeOfNotification(DateTime? createdAt) {
    if (createdAt == null) {
      return '';
    }
    final now = DateTime.now();
    final diff = now.difference(createdAt);
    if (diff.inDays > 0) {
      if (diff.inDays > 365) {
        return '${diff.inDays ~/ 365} ${'txt_year'.tr()}';
      }
      if (diff.inDays > 30) {
        return '${diff.inDays ~/ 30} ${'txt_month'.tr()}';
      }
      return '${diff.inDays} ${'txt_day'.tr()}';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} ${'txt_hour'.tr()}';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} ${'txt_minute'.tr()}';
    } else {
      return '${diff.inSeconds} ${'txt_second'.tr()}';
    }
  }
}

void _goToDetail(NotificationModel notification, BuildContext context) {
  switch (notification.type) {
    case 'BILL':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BillPage(
            apartmentId: notification.apartment ?? "",
            userId: notification.user ?? "",
          ),
        ),
      );
      break;
    default:
    _showDialog(context, notification);
      break;
  }
}

void _showDialog(BuildContext context, NotificationModel notification) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorApp().white,
        title: Center(child: Text(notification.title??"")),
        content: Text(notification.content??""),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('txt_agree'.tr()),
          ),
        ],
      );
    },
  );
}

