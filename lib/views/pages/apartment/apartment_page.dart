import 'dart:ui';

import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/extension.dart';
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/common/common_action_card.dart';
import 'package:ResiEasy/views/common/common_menu_card.dart';
import 'package:ResiEasy/views/pages/apartment/apartment_view_model.dart';
import 'package:ResiEasy/views/pages/bill/bill_page.dart';
import 'package:ResiEasy/views/pages/chat/chatScreen.dart';
import 'package:ResiEasy/views/pages/home/home.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/member/member_page.dart';
import 'package:ResiEasy/views/pages/profile/profile_page.dart';
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

    // Use postFrameCallback to show the dialog after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user.isFirstTime == true) {
        // Show dialog yêu cầu đổi mật khẩu
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: ColorApp().white,
              title: Center(child: Text('txt_notifications'.tr()).bold),
              content: const Center(
                heightFactor: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tài khoản của bạn đang sử dụng mật khẩu sinh ngẫu nhiên từ hệ thống",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                        "Hãy thay đổi mật khẩu của bạn tại mục tài khoản để bảo mật thông tin cá nhân"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Để sau'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: const Text('Đổi mật khẩu'),
                ),
              ],
            );
          },
        );
      }
    });
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
            backgroundColor: Colors.grey.shade300,
            body: Stack(
              children: [
                // AppBar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorApp().cl1,
                  ),
                ),
                // _buildWelcome
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: _buildWelcome(user),
                ),
                // Main content
                Positioned(
                  top: 130,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: ColorApp().cl1,
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
                          _buildActionCard(apartment)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navigate to chat screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(), // Replace with your chat page
                  ),
                );
              },
              backgroundColor: ColorApp().cl1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Đảm bảo bo tròn
              ),
              child: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        },
      ),
    );
  }

  _buildActionCard(Apartment? apartment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return CommonMenuCard(
                index: index,
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
                },
              );
            case 1:
              return CommonMenuCard(
                index: index,
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
                },
              );
            case 2:
              return CommonMenuCard(
                index: index,
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
                },
              );
            case 3:
              return CommonMenuCard(
                index: index,
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
                },
              );
            default:
              return const SizedBox();
          }
        },
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
                    "${'txt_apartment'.tr()} ${apartment?.name ?? 'N/A'}",
                    style: TextStyle(
                        color: ColorApp().white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  if (user.apartments!.length > 1)
                    const Icon(Icons.arrow_drop_down, color: Colors.white)
                ],
              ),
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
                  const Icon(Icons.key, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    "${'txt_householdHead'.tr()} ${viewModel.ownerName?.toUpperCase()}",
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
                  const Icon(Icons.home, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentArea'.tr()} ${apartment?.area ?? 0} m2',
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
                  const Icon(Icons.bed, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    '${'txt_apartmentBedroom'.tr()} ${apartment?.rooms ?? 0}',
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
                    '${'txt_apartmentTotalVehicle'.tr()} ${apartment?.totalVehicle ?? 0}',
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
                    '${'txt_apartmentTotalPeople'.tr()} ${apartment?.totalResidents ?? 0}',
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

  Widget _buildWelcome(User user) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền trong suốt
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.avatar ?? ''),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          '${'txt_hello'.tr()}, ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${user.username}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.phone ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
