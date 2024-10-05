
import 'package:json_annotation/json_annotation.dart';

part 'apartment_model.g.dart';

@JsonSerializable()
class Apartment {
  final String? id;
  final String? name;
  final String? floor;
  final String? block;
  final int? totalResidents;
  final int? totalVehicle;
  final double? price;
  final double ?area;
  final int? rooms;
  final String? status;
  final bool? paid;
  final String? note;
  final DateTime? createAt;
  final DateTime? startAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;
  final List<String>? image;

  Apartment({
    required this.id,
    required this.name,
    this.floor,
    this.block,
    this.totalResidents = 0,
    this.totalVehicle = 0,
    this.price = 3000000,
    this.area = 30,
    this.rooms = 2,
    this.status = 'available',
    this.paid = true,
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
