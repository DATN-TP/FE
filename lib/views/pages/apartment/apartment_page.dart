import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/extension.dart';
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/common/common_action_card.dart';
import 'package:ResiEasy/views/pages/apartment/apartment_view_model.dart';
import 'package:ResiEasy/views/pages/bill/bill_page.dart';
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
  late final User user;

  late String apartmentId;
  String? selectedApartment;

  @override
  void initState() {
    super.initState();
    user = HomePageModel().hiveProvider.getUser()!;
    apartmentId = HomePageModel().hiveProvider.getApartmentId();
    if (apartmentId.isEmpty) {
      apartmentId = user.apartments!.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          ApartmentViewModel()..fetchApartment(apartmentId, user.id ?? ''),
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
                        gradient: LinearGradient(
                          colors: [
                            ColorApp().cl1,
                            ColorApp().lightBlueAccent,
                            ColorApp().cl1,
                            ColorApp().lightBlueAccent,
                          ], // Define your gradient colors here
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
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
                      child: _buildSummary(apartment, viewModel),
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
                          userId: user.id ?? '',
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BillPage(
                          apartmentId: apartment!.id ?? "",
                          userId: user.id ?? '',
                        ),
                      ),
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

  Column _buildSummary(Apartment? apartment, ApartmentViewModel viewModel) {
    final apartmentNames =
        viewModel.listApartment.map((e) => e.name).whereType<String>().toList();
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showApartmentDialog(apartmentNames, viewModel);
          },
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${'txt_apartment'.tr()}: ${apartment?.name ?? 'N/A'}",
                    style:  TextStyle(
                      color: ColorApp().white,
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  if (user.apartments!.length > 1)
                    const Icon(Icons.arrow_drop_down, color: Colors.white)
                ],
              ),
            ),
          ),
        ),
        // Container(
        //   alignment: Alignment.center,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 10),
        //     child: Text(
        //       "${'txt_apartmentPrice'.tr()} ${formatMoneyVND(apartment?.price?.toInt() ?? 0)}/${'txt_month'.tr()}",
        //       style: const TextStyle(
        //           fontSize: 17,
        //           color: Colors.orange,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        SizedBox(
            height: 30,
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.key, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    "${'txt_householdHead'.tr()}: ${viewModel.ownerName?.toUpperCase()}",
                    style: TextStyle(
                        fontSize: 15,
                        color: ColorApp().white,
                        ).bold,
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
                  Icon(Icons.home, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentArea'.tr()}: ${apartment?.area ?? 0} m2',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
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
                  Icon(Icons.bed, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentBedroom'.tr()}: ${apartment?.rooms ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
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
                  const Icon(Icons.directions_car, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentTotalVehicle'.tr()}: ${apartment?.totalVehicle ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
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
                  const Icon(Icons.people, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentTotalPeople'.tr()}: ${apartment?.totalResidents ?? 0}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void _showApartmentDialog(
      List<String> apartmentNames, ApartmentViewModel viewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorApp().white,
          title: Center(child: Text('txt_changeApartment'.tr())),
          content: Center(
            heightFactor: 0.3,
            child: DropdownButton<String>(
              dropdownColor: ColorApp().white,
              value: selectedApartment,
              hint: Text('txt_selectApartment'.tr()),
              items: apartmentNames.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Center(
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                viewModel.fetchApartment(
                    viewModel.listApartment
                        .firstWhere((element) => element.name == newValue)
                        .id!,
                    user.id ?? '');
                setState(() {
                  apartmentId = viewModel.listApartment
                      .firstWhere((element) => element.name == newValue)
                      .id!;
                  HiveProvider().saveApartmentId(apartmentId);
                  selectedApartment = newValue;
                });
                Navigator.of(context).pop(); // Đóng dialog sau khi chọn
              },
            ),
          ),
        );
      },
    );
  }
}
