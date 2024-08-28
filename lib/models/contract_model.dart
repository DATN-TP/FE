import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_model.g.dart';

@JsonSerializable()
class Contract {
  final User? resident;
  final User? admin;
  final Apartment? apartment;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final List<String>? image;
  final String? note;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Contract({
    this.resident,
    this.admin,
    this.apartment,
    required this.startDate,
    required this.endDate,
    this.status = 'active',
    this.image,
    this.note,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
  Map<String, dynamic> toJson() => _$ContractToJson(this);
}
