import 'package:json_annotation/json_annotation.dart';

part 'request_model.g.dart';

@JsonSerializable()
class Request {
  final String title;
  final String description;
  final int status;
  final DateTime createAt;
  final DateTime? updateAt;
  final DateTime? deleteAt;
  final List<String>? image;
  
  Request({
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