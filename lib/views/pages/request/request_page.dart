import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/data/list_request.dart';
import 'package:ResiEasy/views/pages/request/create/create_new_request.dart';
import 'package:ResiEasy/views/pages/request/detail/request_detail_page.dart';
import 'package:ResiEasy/views/pages/request/widget/request_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'txt_feedbackAction'.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorApp().cl1,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              _buildButtonNewRequest(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'txt_listRequest'.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildListRequest(),
            ],
          ),
        ),
      ),
    );
  }

  _buildButtonNewRequest() {
    return InkWell(
        onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateNewRequest(),
                ),
              )
            },
        child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'txt_createNew'.tr(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListRequest() {
    return Expanded(
      child: ListView.builder(
        itemCount: ListRequest.request.length,
        itemBuilder: (context, index) {
          return RequestItem(
            request: ListRequest.request[index],
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RequestDetailPage(),
                  settings:
                      RouteSettings(arguments: ListRequest.request[index]),
                ),
              )
            },
          );
        },
      ),
    );
  }
}
