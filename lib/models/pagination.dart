import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable()
class Pagination {
  @JsonKey(defaultValue: 0)
  int? totalPages;
  Pagination({
    this.totalPages,
  });

  Pagination copyWith({
    int? totalPages,
  }) {
    return Pagination(
      totalPages: totalPages ?? this.totalPages,
    );
  }

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}