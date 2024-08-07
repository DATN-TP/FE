import 'package:datn/views/animations/slideTopToBottom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Logintitle extends StatelessWidget {
  const Logintitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideTopToBottom(
      durationMs: 1500,
      child: Text(
        'txt_login'.tr(),
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
