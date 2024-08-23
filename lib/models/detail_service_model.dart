

import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/service_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_service_model.g.dart';

@JsonSerializable()
class DetailService {
  final Service? service;
  final DateTime? registerAt;
  final User? registerBy;
  final Apartment? apartment;
  final int? quantity;
  final bool? paid;
  final String? note;
  final DateTime? updateAt;
  final DateTime? deleteAt;

  DetailService({
    this.service,
    this.registerAt,
    this.registerBy,
    this.apartment,
    this.quantity,
    this.paid,
    this.note,
    this.updateAt,
    this.deleteAt,
  });

  factory DetailService.fromJson(Map<String, dynamic> json) => _$DetailServiceFromJson(json);
  Map<String, dynamic> toJson() => _$DetailServiceToJson(this);
}
