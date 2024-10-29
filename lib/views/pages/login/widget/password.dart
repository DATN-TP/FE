import 'dart:io';

import 'package:ResiEasy/views/animations/slideTopToBottom.dart';
import 'package:ResiEasy/views/pages/login/login_page_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final TextEditingController controller;
  final bool isBiometric;
  const Password({super.key, required this.controller, required this.isBiometric});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isBiometricEnabled = isBiometric;
    return SlideTopToBottom(
      durationMs: 1500,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(
          screenWidth * 0.05,
          10,
          screenWidth * 0.05,
          10,
        ),
        child: isBiometricEnabled
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: screenWidth * 0.6,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        suffix: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'txt_Password'.tr(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      LoginPageModel().biometricLogin(context);
                    },
                    child: 
                    Platform.isAndroid ?
                    const Icon(
                      Icons.fingerprint,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 50,
                    )
                    : Image.asset(
                      'assets/icon/face_id.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    suffix: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'txt_Password'.tr(),
                  ),
                ),
              ),
      ),
    );
  }
}
