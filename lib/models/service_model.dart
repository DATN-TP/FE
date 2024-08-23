import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable()
class Service {
  final String name;
  final String description;
  final String category;
  final double price;
  final String status;
  final String? image;
  final DateTime createAt;
  final DateTime updateAt;
  final DateTime? deleteAt;

  Service({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    this.status = 'active',
    this.image,
    required this.createAt,
    required this.updateAt,
    this.deleteAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
