import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/views/common/common_action_card.dart';
import 'package:ResiEasy/views/pages/apartment/apartment_view_model.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/member/member_page.dart';
import 'package:ResiEasy/views/pages/request/request_page.dart';
import 'package:ResiEasy/views/pages/vehicle/vehicle_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ApartmentPage extends StatefulWidget {
  const ApartmentPage({super.key});

  @override
  State<ApartmentPage> createState() => _ApartmentPageState();
}

String formatMoneyVND(int amount) {
  final NumberFormat formatter =
      NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  return formatter.format(amount);
}

class _ApartmentPageState extends State<ApartmentPage> {
  final user = HomePageModel().hiveProvider.getUser();
  String? apartmentId;

  @override
  void initState() {
    super.initState();
    apartmentId = user?.apartments?.first;
  }

  @override
  Widget build(BuildContext context) {
    // Get the user and apartment ID
    // assuming there is at least one apartment

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
            appBar: AppBar(
              title: Text('txt_apartment'.tr(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              automaticallyImplyLeading: false,
              backgroundColor: ColorApp().cl1,
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: _buildSummary(apartment),
                    ),
                    const SizedBox(height: 20),
                    _buildActionCard(apartment)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView _buildActionCard(Apartment? apartment) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'txt_feature'.tr(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          CommonActionCard(
              icon: Icon(Icons.assignment, color: ColorApp().cl1),
              title: Text('txt_feedbackAction'.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RequestPage(
                          apartmentId: apartment!.id ?? "",
                          userId: user?.id ?? '',
                        ),
                      ),
                    )
                  }),
          CommonActionCard(
              icon: Icon(Icons.payment, color: ColorApp().cl1),
              title: Text('txt_listBill'.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              onPressed: () => {
                    Navigator.pushNamed(
                      context,
                      "/billPage",
                    )
                  }),
          CommonActionCard(
              icon: Icon(Icons.cleaning_services, color: ColorApp().cl1),
              title: Text('txt_listService'.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              onPressed: () => {}),
          CommonActionCard(
              icon: Icon(Icons.group_outlined, color: ColorApp().cl1),
              title: Text('txt_listMember'.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MemberPage(),
                        settings: RouteSettings(arguments: apartment?.id),
                      ),
                    ),
                  }),
          CommonActionCard(
              icon: Icon(Icons.directions_car_filled, color: ColorApp().cl1),
              title: Text('txt_listVehicle'.tr(),
                  style: const TextStyle(
                    fontSize: 17,
                  )),
              onPressed: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => VehiclePage(
                          id: apartment?.id ?? '',
                        ),
                      ),
                    ),
                  }),
        ],
      ),
    );
  }

  Column _buildSummary(Apartment? apartment) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${'txt_apartment'.tr()}: ${apartment?.name ?? 'N/A'}",
              style: const TextStyle(
                  fontSize: 25,
                  color: Color(0xff8554E8),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              "${'txt_apartmentPrice'.tr()} ${formatMoneyVND(apartment?.price?.toInt() ?? 0)}/${'txt_month'.tr()}",
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.key, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(
                    "${'txt_householdHead'.tr()} Huỳnh Hữu Phước",
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.home, color: Colors.blue[200]),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentArea'.tr()} ${apartment?.area ?? 0} m2',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.bed, color: Colors.green[200]),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentBedroom'.tr()} ${apartment?.rooms ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_car, color: Colors.orange),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentTotalVehicle'.tr()} ${apartment?.totalVehicle ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.people, color: Colors.pink),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentTotalPeople'.tr()} ${apartment?.totalResidents ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
