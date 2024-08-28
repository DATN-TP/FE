import 'package:ResiEasy/models/apartment_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final DateTime dob;
  final String role;
  final String address;
  final List<String>? apartments;
  final bool houseHoldHead;
  final String relationship;
  final String position;
  final String avatar;
  final String refreshToken;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    required this.dob,
    required this.role,
    this.address = '',
    this.apartments,
    this.houseHoldHead = false,
    this.relationship = 'Người thân',
    this.position = '',
    this.avatar = '',
    this.refreshToken = '',
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

