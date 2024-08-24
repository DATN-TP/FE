import 'package:ResiEasy/views/pages/notifications/widget/Notification_Item.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
            child: const Column(
              children: [
                //sau này dùng list build ra
                  NotificationItem(),
                  NotificationItem(),
                  NotificationItem(),
                  NotificationItem(),
                  NotificationItem(),
                  NotificationItem(),
                  NotificationItem(),
              ],
            ),
          ),
      ),
    );
  }
}