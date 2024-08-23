import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/models/block_model.dart';
import 'package:ResiEasy/models/contract_model.dart';
import 'package:ResiEasy/models/detail_service_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/models/vehicle_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apartment_model.g.dart';

@JsonSerializable()
class Apartment {
  final String name;
  final String? floor;
  final String? block;
  final List<String>? residents;
  final int totalResidents;
  final List<String>? vehicles;
  final int totalVehicle;
  final double price;
  final double area;
  final int rooms;
  final List<String>? service;
  final String status;
  final bool paid;
  final List<String>? bills;
  final Contract? contract;
  final String? note;
  final DateTime createAt;
  final DateTime? startAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;
  final List<String>? image;

  Apartment({
    required this.name,
    this.floor,
    this.block,
    this.residents,
    this.totalResidents = 0,
    this.vehicles,
    this.totalVehicle = 0,
    this.price = 3000000,
    this.area = 30,
    this.rooms = 2,
    this.service,
    this.status = 'available',
    this.paid = true,
    this.bills,
    this.contract,
    this.note,
    required this.createAt,
    this.startAt,
    this.updateAt,
    this.deleteAt,
    this.image,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) => _$ApartmentFromJson(json);
  Map<String, dynamic> toJson() => _$ApartmentToJson(this);
}
