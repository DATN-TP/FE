import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/common/common_action_card.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/profile/account_infor_page.dart';
import 'package:ResiEasy/views/pages/profile/widget/buttonLogOut.dart';
import 'package:ResiEasy/views/pages/profile/widget/profile_page_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = HomePageModel().hiveProvider.getUser();
    return ChangeNotifierProvider(
      create: (_) => ProfilePageModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "txt_profile".tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
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
                _buildMainView(),
                _buildLogoutButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainView() {
    return Consumer<ProfilePageModel>(
      builder: (context, profilePageModel, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "txt_verify".tr(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                _buildBiometricSwitch(profilePageModel),
                _buildActionAccount(profilePageModel),
                _buildActionApp(profilePageModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBiometricSwitch(ProfilePageModel profilePageModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.fingerprint, color: ColorApp().cl1),
                  const SizedBox(width: 10),
                  Text("txt_biometricLogin".tr()),
                ],
              ),
              Switch(
                activeColor: ColorApp().cl1,
                value: profilePageModel.isBiometricEnabled,
                onChanged: (value) {
                  profilePageModel.switchBiometric(value);
                },
              )
            ],
          ),
        ),
      ),
    );
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

  _buildActionAccount(ProfilePageModel profilePageModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "txt_account".tr(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CommonActionCard(
              icon: Icon(Icons.person, color: ColorApp().cl1),
              title: Text("txt_profileInfo".tr()),
              onPressed: () => {
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AccountInforPage(),
                ),
              )
            },
            ),
          CommonActionCard(
              icon: Icon(Icons.password, color: ColorApp().cl1),
              title: Text("txt_changePassword".tr()),
              onPressed: () => _showChangePasswordDialog(context)),
        ],
      ),
    );
  }

  _buildActionApp(ProfilePageModel profilePageModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "txt_applications".tr(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CommonActionCard(
              icon: Icon(Icons.language, color: ColorApp().cl1),
              title: Text("txt_changeLanguage".tr()),
              onPressed: () => _showLanguageBottomSheet(context)),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('assets/icon/vietnam.png',
                    width: 24, height: 24),
                title: const Text('Tiếng Việt'),
                onTap: () {
                  setState(() {
                    context.setLocale(const Locale('vi', 'VN'));
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: Image.asset('assets/icon/england.png',
                    width: 24, height: 24),
                title: const Text('English'),
                onTap: () {
                  setState(() {
                    context.setLocale(const Locale('en', 'US'));
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _buildLogoutButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        child: Text(
          'txt_logout'.tr(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void _showChangePasswordDialog(BuildContext context) {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
            alignment: Alignment.center,
            child: Text('txt_changePassword'.tr())),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                labelText: 'txt_currentPassword'.tr(),
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp().cl1),
                ),
              ),
              obscureText: true,
            ),
           const SizedBox(height: 15),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                labelText: 'txt_newPassword'.tr(),
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp().cl1),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'txt_confirmNewPassword'.tr(),
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorApp().cl1),
                ),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('txt_cancel'.tr(), style: const TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {

              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                Navigator.of(context).pop();
              } else {
              }
            },
            child: Text('txt_confirm'.tr(), style: TextStyle(color: ColorApp().cl1)),
          ),
        ],
      );
    },
  );
}
