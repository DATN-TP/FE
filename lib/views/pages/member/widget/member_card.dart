import 'package:ResiEasy/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCard extends StatelessWidget {

  final User? user;

  MemberCard({super.key, required this.user});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Không thể thực hiện cuộc gọi đến $phoneNumber';
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': 'Tiêu đề email',
        'body': 'Nội dung email',
      },
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Không thể mở email tới $emailAddress';
    }
  }

final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user?.avatar ?? ''),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(user!.username!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(user!.relationship??"", style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _makePhoneCall(user!.phone ?? ''),
            child: Row(
              children: [
                const Icon(Icons.phone, color: Colors.blue,),
                const SizedBox(width: 10),
                Text(user!.phone ?? 'Chưa cập nhật'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _sendEmail(user!.email??""),
            child: Row(
              children: [
                const Icon(Icons.email, color: Colors.blue,),
                const SizedBox(width: 10),
                //regexp email
                 Text(
                  emailRegex.hasMatch(user!.email ?? '') ? user!.email! : 'Chưa cập nhật',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
