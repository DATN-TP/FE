
import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/service_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class Bill {
  final String? apartment;
  final List<Service>? service;
  final double amount;
  final String status;
  final DateTime date;
  final String paymentMethod;
  final DateTime? paymentDate;
  final String? paymentBy;
  final String? note;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;
  final bool paid;

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
      this.paid = false,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

