import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/apartment/apartment_view_model.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApartmentPage extends StatefulWidget {
  const ApartmentPage({super.key});

  @override
  State<ApartmentPage> createState() => _ApartmentPageState();
}

class _ApartmentPageState extends State<ApartmentPage> {

  @override
  Widget build(BuildContext context) {
    // Get the user and apartment ID
    final user = HomePageModel().hiveProvider.getUser();
    final apartmentId = user?.apartments?.first; // assuming there is at least one apartment

    return ChangeNotifierProvider(
      create: (context) => ApartmentViewModel()..fetchApartment(apartmentId!),
      child: Consumer<ApartmentViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (viewModel.error != null) {
            return Scaffold(
              body: Center(child: Text('Error: ${viewModel.error}')),
            );
          }

          final apartment = viewModel.apartment;

          return Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:  Text(
                              "${'txt_apartment'.tr()}: ${apartment?.name ?? 'N/A'}",
                              style: const TextStyle(fontSize: 25, color: Color(0xff8554E8), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
