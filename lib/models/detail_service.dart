import 'package:ResiEasy/models/service_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_service.g.dart';

@JsonSerializable()
class DetailService {
  String? id;
  Service? service;
  DateTime? registerAt;
  String? registerBy;
  String? apartment;
  int? quantity;
  bool? paid;
  String? note;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  DetailService({
    this.id,
    this.service,
    this.registerAt,
    this.registerBy,
    this.apartment,
    this.quantity,
    this.paid,
    this.note,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });

  factory DetailService.fromJson(Map<String, dynamic> json) => _$DetailServiceFromJson(json);

  Map<String, dynamic> toJson() => _$DetailServiceToJson(this);

}