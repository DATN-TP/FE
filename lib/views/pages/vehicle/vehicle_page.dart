import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/pages/member/member_view_model.dart';
import 'package:ResiEasy/views/pages/vehicle/vehicle_view_model.dart';
import 'package:ResiEasy/views/pages/vehicle/widget/vehicle_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  
  @override
  Widget build(BuildContext context) {
        final id = ModalRoute.of(context)?.settings.arguments as String?;

     return ChangeNotifierProvider(
      create: (context) => VehicleViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('txt_listVehicle'.tr(),
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
        body: Consumer<VehicleViewModel>(
            builder:
                (BuildContext context, VehicleViewModel viewModel, Widget? child) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viewModel.error != null) {
                return Center(child: Text('Error: ${viewModel.error}'));
              }
              return ListView.builder(
                itemCount: viewModel.listVehicle.length,
                itemBuilder: (context, index) {
                  return VehicleItem();
                },
              );
                
          }
        )
      
      ),
    );
  }
}