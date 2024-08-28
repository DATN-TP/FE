import 'dart:math';
import 'dart:developer' as dev;

import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/member/member_view_model.dart';
import 'package:ResiEasy/views/pages/member/widget/member_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String?;

    return ChangeNotifierProvider(
      create: (context) => MemberViewModel()..getListUserByApartment(id!),
      child: Scaffold(
        appBar: AppBar(
          title: Text('txt_listMember'.tr(),
              style: const TextStyle(
                color: Colors.white,
              )),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: ColorApp().cl1,
        ),
        body: Consumer<MemberViewModel>(
          builder:
              (BuildContext context, MemberViewModel viewModel, Widget? child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }
            List<User> listUser = viewModel.listUser;
            return ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return MemberCard(user: listUser[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
