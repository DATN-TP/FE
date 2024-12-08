
import 'package:ResiEasy/models/detail_service.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class Bill {
  String? id;
  String? apartment;
  String? resident;
  double? price;
  double? electric;
  double? water;
  List<DetailService>? service;
  List<VehicleBill>? listVehicle;
  double? oldElectricNumber;
  double? oldWaterNumber;
  double? newElectricNumber;
  double? newWaterNumber;
  double? managementFee;
  int? ePrice;
  int? eQuota;
  int? eQuota1;
  int? eQuota2;
  int? eQuota3;
  int? wQuota;
  int? wQuota1;
  int? wQuota2;
  int? wQuota3;
  int? wPrice;
  int?managementPrice;
  String? status;
  DateTime? date;
  String? paymentMethod;
  DateTime? paymentDate;
  User? paymentBy;
  double? total;
  String? note;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  Bill({
    this.id,
    this.apartment,
    this.resident,
    this.price,
    this.electric,
    this.water,
    this.service,
    this.listVehicle,
    this.oldElectricNumber,
    this.oldWaterNumber,
    this.newElectricNumber,
    this.managementFee,
    this.ePrice,
    this.eQuota,
    this.eQuota1,
    this.eQuota2,
    this.eQuota3,
    this.wQuota,
    this.wQuota1,
    this.wQuota2,
    this.wQuota3,
    this.wPrice,
    this.managementPrice,
    this.newWaterNumber,
    this.status,
    this.date,
    this.paymentMethod,
    this.paymentDate,
    this.paymentBy,
    this.total,
    this.note,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });


  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

@JsonSerializable()
class VehicleBill {
  String? type;
  double? price;
  double? quantity;
  double? total;

  VehicleBill({
    this.type,
    this.price,
    this.quantity,
    this.total,
  });

  factory VehicleBill.fromJson(Map<String, dynamic> json) => _$VehicleBillFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleBillToJson(this);
}

