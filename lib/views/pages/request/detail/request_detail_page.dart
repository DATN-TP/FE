import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/request_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RequestDetailPage extends StatefulWidget {
  const RequestDetailPage({super.key});

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  @override
  Widget build(BuildContext context) {
    final request = ModalRoute.of(context)?.settings.arguments as Request?;
    return Scaffold(
      appBar: AppBar(
        title: Text('txt_requestDetail'.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: ColorApp().cl1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusRequest(request),
              if (request!.status == -1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('txt_reasonReject'.tr(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                    _buildReasonRejectRequest(request),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('txt_title'.tr(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              _buildTitleRequest(request),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('txt_content'.tr(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              _buildContentRequest(request),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('txt_image'.tr(),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              _buildImageRequest(request),
            ],
          ),
        ),
      ),
    );
  }

  _buildStatusRequest(Request? request) {
    bool isCheckActiveStep1 = false;
    bool isCheckActiveStep2 = false;
    bool isCheckActiveStep3 = false;
    bool isCheckActiveStep4 = false;
    bool isRejected = false;

    switch (request!.status) {
      case -1:
        isRejected = true;
        break;
      case 0:
        isCheckActiveStep1 = true;
        break;
      case 1:
        isCheckActiveStep1 = true;
        isCheckActiveStep2 = true;
        break;
      case 2:
        isCheckActiveStep1 = true;
        isCheckActiveStep2 = true;
        isCheckActiveStep3 = true;
        break;
      case 3:
        isCheckActiveStep1 = true;
        isCheckActiveStep2 = true;
        isCheckActiveStep3 = true;
        isCheckActiveStep4 = true;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isRejected == true
            ? Center(
                child: Container(
                  width: double.infinity,
                  padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border:  Border.all(color: Colors.red),
                  ),
                  child: Center(
                    child: Text('txt_rejected'.tr(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.bold)),
                  ),
                ))
            : Center(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildCircle(
                          Text('txt_sent'.tr(),
                              style: const TextStyle(fontSize: 10)),
                          true,
                          isCheckActiveStep1),
                      _buildCircle(
                          Text('txt_received'.tr(),
                              style: const TextStyle(fontSize: 10)),
                          true,
                          isCheckActiveStep2),
                      _buildCircle(
                          Text('txt_pending'.tr(),
                              style: const TextStyle(fontSize: 10)),
                          true,
                          isCheckActiveStep3),
                      _buildCircle(
                          Text('txt_approved'.tr(),
                              style: const TextStyle(fontSize: 10)),
                          false,
                          isCheckActiveStep4),
                    ],
                  ),
                ),
            ),
      ),
    );
  }

  _buildTitleRequest(Request? request) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        request!.title,
        style: const TextStyle(fontSize: 15),
      ), // Replace 'Your child widget here' with the actual child widget you want to use.
    );
  }

  _buildCircle(Text text, bool isCheckFinalStep, bool isCheckActiveStep) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isCheckActiveStep == true ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
              child: isCheckActiveStep == true
                  ? const Icon(Icons.check, color: Colors.white, size: 15)
                  : null,
            ),
            const SizedBox(height: 5),
            text,
          ],
        ),
        if (isCheckFinalStep == true) _buildDash(isCheckActiveStep),
      ],
    );
  }

  _buildDash(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 30,
      height: 5,
      color: isActive == true ? Colors.green : Colors.grey,
    );
  }

  _buildContentRequest(Request? request) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        request!.description,
        style: const TextStyle(fontSize: 15),
      ), 
    );
  }

  _buildImageRequest(Request? request) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: request!.image!
            .map((e) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(e),
                ))
            .toList(),
      ),
    );
  }

  _buildReasonRejectRequest(Request request) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: const Text(
        "chưa có dữ liệu nha ní ơi",
        style: TextStyle(fontSize: 15),
      ), 
    );
  }
}
