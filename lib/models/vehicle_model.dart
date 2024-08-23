import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class Vehicle {
  final User? owner;
  final Apartment? apartment;
  final String name;
  final String type;
  final String color;
  final String brand;
  final String licensePlate;
  final String? parking;
  final List<String>? image;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Vehicle({
    this.owner,
    this.apartment,
    required this.name,
    required this.type,
    required this.color,
    required this.brand,
    required this.licensePlate,
    this.parking,
    this.image,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => _$VehicleFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
