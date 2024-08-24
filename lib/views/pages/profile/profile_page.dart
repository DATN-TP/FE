import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/common/common_action_card.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/profile/widget/buttonLogOut.dart';
import 'package:ResiEasy/views/pages/profile/widget/profile_page_model.dart';
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
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                _buildUserInfo(user!),
                _buildMainView(),
                const Buttonlogout(),
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
               const  Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Xác thực",
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
              const Row(
                children:  [
                  Icon(Icons.fingerprint, color: Color(0xFFac3bff)),
                  SizedBox(width: 10),
                  Text("Đăng nhập bằng vân tay"),
                ],
              ),
              Switch(
                activeColor: Color(0xFFac3bff),

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
      margin: const EdgeInsets.only(top: 30),
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
            const  Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Tài khoản",
                      style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          CommonActionCard(icon: const Icon(Icons.person,color: Color(0xFFac3bff)), 
          title: Text("Thông tin cá nhân"), 
          onPressed: ()=>{}),
          CommonActionCard(icon: const Icon(Icons.password, color: Color(0xFFac3bff)), 
          title: Text("Đổi mật khẩu"), 
          onPressed: ()=>{}),
        ],
      ),
    );
  }
  
  _buildActionApp(ProfilePageModel profilePageModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
            const  Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text(
                      "Ứng dụng",
                      style:  TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          CommonActionCard(icon: const Icon(Icons.language, color: Color(0xFFac3bff)), 
          title: Text("Ngôn ngữ"), 
          onPressed: ()=>{}),
        ],
      ),
    );
  }
}
