import 'package:datn/services/biometric_service.dart';
import 'package:datn/views/pages/profile/profile_page_model.dart';
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
    return ChangeNotifierProvider(
      create: (_) => ProfilePageModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Profile Page')),
        body: Center(
          child: _buildMainView(),
        ),
      ),
    );
  }

  Widget _buildMainView() {
    return Consumer<ProfilePageModel>(
      builder: (context, profilePageModel, child) {
        return Column(
          children: [
            _buildBiometricSwitch(profilePageModel),
          ],
        );
      },
    );
  }

  Widget _buildBiometricSwitch(ProfilePageModel profilePageModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Enable Biometric'),
              Switch(
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
}
