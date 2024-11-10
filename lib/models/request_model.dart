import 'package:ResiEasy/models/apartment_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable()
class Request {
  final User? owner;
  final Apartment? apartment;
  String? type;
  final String title;
  final String description;
  int status;
  final DateTime createAt;
  DateTime? updateAt;
  DateTime? deleteAt;
  final List<String>? image;
  
  Request({
    required this.owner,
    required this.apartment,
    required this.title,
    required this.description,
    required this.status,
    required this.createAt,
    this.updateAt,
    this.deleteAt,
    this.image,
  });

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestToJson(this);
}