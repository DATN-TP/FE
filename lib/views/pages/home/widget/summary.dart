import 'dart:math';

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
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff712BBC),
              Color(0xff715BBC),
              Color(0xffc9c9c9),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
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
                  '${'txt_hello'.tr()} ${user?.username ?? ''}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Payable: 1.000.000 VND',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                PayNowButton(),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_outlined, color: Colors.blue),
                        SizedBox(width: 5),
                        Text('Hạn cuối: 20/10/2024'),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}