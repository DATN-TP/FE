import 'dart:math';

import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/home/widget/pay_now_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});
  
  @override
  Widget build(BuildContext context) {
    User? user = HomePageModel().hiveProvider.getUser();
    return Positioned(
      bottom: 0,
      left: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.blue.shade200.withOpacity(0.7),
          color: ColorApp().white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${'txt_hello'.tr()},  ${user?.username ?? ''}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorApp().black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Căn hộ: A1-L1-1',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.directions_car, color: Colors.orange),
                        SizedBox(width: 5),
                        Text('Tổng số phương tiện cá nhân: 1', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_month_outlined, color: Colors.blue),
                        SizedBox(width: 5),
                        Text('Ngày gia nhập: 20/6/2024', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),),
                      ],
                    ),
                  ),
                ),
              ],
            )
              
          ],
        ),
      ),
    );
  }
}