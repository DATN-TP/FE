import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'block_model.g.dart';

@JsonSerializable()
class Block {
  final String name;
  final List<Floor>? floors;
  final int? totalFloors;
  final int? totalApartments;
  final int? totalResidents;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Block({
    required this.name,
    this.floors,
    this.totalFloors,
    this.totalApartments,
    this.totalResidents,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
  Map<String, dynamic> toJson() => _$BlockToJson(this);
}

@JsonSerializable()
class Floor {
  final String name;
  final Block? block;
  final List<Apartment>? apartments;
  final int? totalApartments;
  final int? totalResidents;
  final User? manager;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Floor({
    required this.name,
    this.block,
    this.apartments,
    this.totalApartments,
    this.totalResidents,
    this.manager,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);
  Map<String, dynamic> toJson() => _$FloorToJson(this);
}
