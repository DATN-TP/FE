import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/pages/notifications/widget/Notification_Item.dart';
import 'package:easy_localization/easy_localization.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'txt_notifications'.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorApp().cl1,
        titleSpacing: 0,
        centerTitle: true,
      ),
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