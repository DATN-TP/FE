import 'dart:async';
import 'package:ResiEasy/data/config/colors.dart';
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
        selectedItemColor:  ColorApp().cl1, // Color for selected label
        unselectedItemColor: Colors.black,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home, color: Colors.grey,),
            activeIcon:  Icon(Icons.home, color: ColorApp().cl1),
            label: 'txt_home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.apartment, color: Colors.grey,),
            activeIcon:  Icon(Icons.apartment, color: ColorApp().cl1),
            label: 'txt_apartment'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications, color: Colors.grey,),
            activeIcon:  Icon(Icons.notifications, color: ColorApp().cl1),
            label: 'txt_notifications'.tr(),  
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle, color: Colors.grey,),
            activeIcon:  Icon(Icons.account_circle, color: ColorApp().cl1),
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
                    // _buildSlide(),
                    const News(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _renderImageBackGround(BuildContext context) {
    return SizedBox(
      height: 320,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/background.png',
        fit: BoxFit.fitWidth,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildSlide() {
    return const ImageSlider();
  }
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> _images = [
    'https://res.cloudinary.com/ds3qf4ip3/image/upload/v1724309107/apartment3_tuwsjx.jpg',
    'https://res.cloudinary.com/ds3qf4ip3/image/upload/v1724309107/apartment3_tuwsjx.jpg',
    'https://res.cloudinary.com/ds3qf4ip3/image/upload/v1724309107/apartment3_tuwsjx.jpg',
  ];
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 200, // Chiều cao của slider
        child: PageView.builder(
          controller: _pageController,
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return Image.network(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
            );
          },
        ),
      ),
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
