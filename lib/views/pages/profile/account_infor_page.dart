import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/profile/widget/profile_page_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountInforPage extends StatefulWidget {
  const AccountInforPage({super.key});

  @override
  State<AccountInforPage> createState() => _AccountInforPageState();
}

class _AccountInforPageState extends State<AccountInforPage> {
  @override
  Widget build(BuildContext context) {
  final user = HomePageModel().hiveProvider.getUser();
    return ChangeNotifierProvider(
      create: (_) => ProfilePageModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "txt_profileInfo".tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: ColorApp().cl1,
          titleSpacing: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                _buildUserInfo(user!),
                _buidMainView(user!),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  _buidMainView(User user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            //hiển thị thông tin cá nhân như ngày sinh, địa chỉ, email, giới tính
            _buildInfoItem("txt_birthday".tr(), formatDate(user.dob)),
            _buildInfoItem("txt_address".tr(), user.address),
            _buildInfoItem("txt_email".tr(), user.email),
          ],
        ),
      ),
    );
  }
  
  _buildInfoItem(String tr, String tr2) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              "$tr:",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                tr2,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
  }

  _buildUserInfo(User user) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: Image.network(user.avatar).image,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.phone.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          )
        ]),
      ),
    );
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }