// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contract _$ContractFromJson(Map<String, dynamic> json) => Contract(
      resident: json['resident'] == null
          ? null
          : User.fromJson(json['resident'] as Map<String, dynamic>),
      admin: json['admin'] == null
          ? null
          : User.fromJson(json['admin'] as Map<String, dynamic>),
      apartment: json['apartment'] == null
          ? null
          : Apartment.fromJson(json['apartment'] as Map<String, dynamic>),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: json['status'] as String? ?? 'active',
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      note: json['note'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
    );

Map<String, dynamic> _$ContractToJson(Contract instance) => <String, dynamic>{
      'resident': instance.resident,
      'admin': instance.admin,
      'apartment': instance.apartment,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': instance.status,
      'image': instance.image,
      'note': instance.note,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
