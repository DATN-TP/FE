import 'package:ResiEasy/data/config/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NoResultWidget extends StatefulWidget {
  const NoResultWidget({super.key});

  @override
  State<NoResultWidget> createState() => _NoResultWidgetState();
}

class _NoResultWidgetState extends State<NoResultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
           Image.asset('assets/images/no_result.png', width: 200, height: 200),
            const SizedBox(height: 10),
            Text(
              'txt_noData'.tr(),
              style:  TextStyle(
                fontSize: 20,
                color: ColorApp().grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}