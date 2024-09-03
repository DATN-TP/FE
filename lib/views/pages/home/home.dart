import 'package:datn/models/user_model.dart';
import 'package:datn/views/pages/home/home_page_model.dart';
import 'package:datn/views/pages/home/widget/menu.dart';
import 'package:datn/views/pages/home/widget/news.dart';
import 'package:datn/views/pages/home/widget/summary.dart';
import 'package:datn/views/pages/profile/profile_page.dart';
import 'package:datn/views/pages/message/message_page.dart';
import 'package:flutter/cupertino.dart';
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
        return const HomePage(); // Use a separate widget for the home page
      case 1:
        return MessagePage(); // Update to use the Business widget
      case 2:
        return const Profile(); // Update to use the School widget
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        _renderImageBackGround(context),
                        const Summary(),
                      ],
                    ),
                    const Menu(),
                    const News(),
                  ],
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
          'assets/images/city.png',
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ));
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
