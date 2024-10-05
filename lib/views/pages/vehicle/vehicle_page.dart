import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/views/pages/vehicle/vehicle_view_model.dart';
import 'package:ResiEasy/views/pages/vehicle/widget/vehicle_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehiclePage extends StatefulWidget {
  final String id;
  const VehiclePage({super.key, required this.id});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VehicleViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "txt_listVehicle".tr(),
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
                _buildListVehicle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  _buildListVehicle() {
    return ChangeNotifierProvider(
      create: (context) => VehicleViewModel()..getListVehicleByApartment(widget.id),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Consumer<VehicleViewModel>(
          builder: (BuildContext context, VehicleViewModel viewModel, Widget? child) {
            return Column(
              children: [
                //listview
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: viewModel.listVehicle.length,
                  itemBuilder: (context, index) {
                    return VehicleItem(vehicle: viewModel.listVehicle[index],);
                  },
                ),
              ],
            );
          }
        ),
      ),
    );
  }
  }
