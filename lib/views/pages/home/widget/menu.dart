import 'package:ResiEasy/data/config/colors.dart';
import 'package:flutter/material.dart';
import '../../../../data/data/list_services.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
  width: MediaQuery.of(context).size.width * 0.95,
  height: 220,
  decoration: BoxDecoration(
    boxShadow: const [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 10,
        spreadRadius: 5,
        offset: Offset(0, 7),
      ),
    ],
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorApp().cl1,
        const Color(0xffc9c9c9),
      ],
    ),
    borderRadius: const BorderRadius.all(
      Radius.circular(20),
    ),
  ),
  child: SingleChildScrollView(
    child: Align(
      alignment: Alignment.topCenter,
      child: GridView.count(
        controller: _scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        children: ListServices.services.map((service) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (service as Map<String, dynamic>)['background'] ??
                        Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: IconButton(
                    icon: (service)['icon'],
                    onPressed: () {},
                    iconSize: 30,
                    color: service['color'],
                  ),
                ),
                Text(
                  service['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),
  ),
);
  }
}
