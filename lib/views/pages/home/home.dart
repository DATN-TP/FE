import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/home/home_page_model.dart';
import 'package:ResiEasy/views/pages/home/widget/menu.dart';
import 'package:ResiEasy/views/pages/home/widget/news.dart';
import 'package:ResiEasy/views/pages/home/widget/summary.dart';
import 'package:ResiEasy/views/pages/notifications/notification_page.dart';
import 'package:ResiEasy/views/pages/profile/profile_page.dart';
import 'package:ResiEasy/views/pages/apartment/apartment_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const HomePage(); 
      case 1:
        return const ApartmentPage(); 
      case 2:
        return const NotificationPage();
      case 3:
        return const Profile(); 
      default:
        return const HomePage(); // Fallback to HomePage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFac3bff), // Color for selected label
        unselectedItemColor: Colors.black,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.grey,),
            activeIcon: const Icon(Icons.home, color: Color(0xFFac3bff)),
            label: 'txt_home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apartment, color: Colors.grey,),
            activeIcon: const Icon(Icons.apartment, color: Color(0xFFac3bff)),
            label: 'txt_apartment'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications, color: Colors.grey,),
            activeIcon: const Icon(Icons.notifications, color: Color(0xFFac3bff)),
            label: 'txt_notifications'.tr(),  
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle, color: Colors.grey,),
            activeIcon: const Icon(Icons.account_circle, color: Color(0xFFac3bff)),
            label: 'txt_profile'.tr(),  
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  // ignore: unused_local_variable
  User? user = HomePageModel().hiveProvider.getUser();
    return ChangeNotifierProvider(
      create: (_) => HomePageModel(),
      child: Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Consumer<HomePageModel>(
              builder: (context, loginPageModel, child) {
              return Container(
                color: Colors.grey.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        _renderImageBackGround(context),
                        const Summary(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Menu(),
                    const News(),
                  ],
                ),
              );
              },
            ),
          )),
    );
  }

  Widget _renderImageBackGround(BuildContext context) {
    return SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          'assets/images/background.png',
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ));
  }
}

class Business extends StatelessWidget {
  const Business({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Business Page'),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProfilePage(),
    );
  }
}
