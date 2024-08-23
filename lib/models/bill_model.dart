
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/service_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class Bill {
  final Apartment? apartment;
  final List<Service>? service;
  final double amount;
  final String status;
  final DateTime date;
  final String paymentMethod;
  final DateTime? paymentDate;
  final User? paymentBy;
  final String? note;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Bill({
    this.apartment,
    this.service,
    required this.amount,
    required this.status,
    required this.date,
    required this.paymentMethod,
    this.paymentDate,
    this.paymentBy,
    this.note,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

