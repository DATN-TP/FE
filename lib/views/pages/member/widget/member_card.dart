import 'package:ResiEasy/models/user_model.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {

  final User? user;

  const MemberCard({super.key, required this.user});

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
                  Text(user!.username, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(user!.relationship, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.blue,),
              const SizedBox(width: 10),
              Text(user!.phone ?? 'Chưa cập nhật'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.blue,),
              const SizedBox(width: 10),
               Text(user!.email),
            ],
          ),
        ],
      ),
    );
  }
}