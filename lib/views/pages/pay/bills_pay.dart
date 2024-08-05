import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BillsPay extends StatelessWidget {
  const BillsPay({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(
            tabAlignment: TabAlignment.fill,
            dividerColor: Color(0xff712BBC),
            labelColor: Color(0xff712BBC),
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            indicatorColor: Color(0xff712BBC),
            tabs: [
              Tab(
                icon: Icon(Icons.home_rounded),
                text: 'Rent',
              ),
              Tab(
                icon: Icon(Icons.electrical_services),
                text: 'Electricity',
              ),
              Tab(
                icon: Icon(Icons.water),
                text: 'Water',
              ),
              Tab(
                icon: Icon(Icons.sign_language),
                text: 'Service',
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              Rent(),
              Electricity(),
              Water(),
              Service(),
            ],
          ),
        ),
      ),
    );
  }
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Electricity extends StatelessWidget {
  const Electricity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Water extends StatelessWidget {
  const Water({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Service extends StatelessWidget {
  const Service({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
