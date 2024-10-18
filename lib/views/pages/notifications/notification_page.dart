import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/views/pages/notifications/notification_view_model.dart';
import 'package:ResiEasy/views/pages/notifications/widget/Notification_Item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  Widget build(BuildContext context) {
  String id = HiveProvider().getUser()?.id??"";
  String apartmentId = HiveProvider().getApartmentId();
  print("apartmentId: $apartmentId");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'txt_notifications'.tr(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorApp().cl1,
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => NotificationViewModel()..getListNotificationByUser(apartmentId, id, 1, 10),
        child: Consumer<NotificationViewModel>(
          builder: (BuildContext context, NotificationViewModel viewModel, Widget? child) {
      return SafeArea(
        child: Container(
          color: Colors.white,
            child: ListView.builder(
              itemCount: viewModel.listNotification.length,
              itemBuilder: (context, index) {
                return  NotificationItem(
                  notification: viewModel.listNotification[index],
                  onTap: () {
                    if(viewModel.listNotification[index].isRead == false){
                      viewModel.listNotification[index].isRead = true;
                      viewModel.readNotification(viewModel.listNotification[index].id ?? '');
                      setState(() {
                      });
                    }},
                );
              },
            )
          ),
      );
    },
      ),

    ),
    );
  }
}