// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailService _$DetailServiceFromJson(Map<String, dynamic> json) =>
    DetailService(
      id: json['_id'] as String?,
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      registerAt: json['registerAt'] == null
          ? null
          : DateTime.parse(json['registerAt'] as String),
      registerBy: json['registerBy'] as String?,
      apartment: json['apartment'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      paid: json['paid'] as bool?,
      note: json['note'] as String?,
      createAt: json['createAt'] == null
          ? null
          : DateTime.parse(json['createAt'] as String),
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
    );

Map<String, dynamic> _$DetailServiceToJson(DetailService instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'service': instance.service,
      'registerAt': instance.registerAt?.toIso8601String(),
      'registerBy': instance.registerBy,
      'apartment': instance.apartment,
      'quantity': instance.quantity,
      'paid': instance.paid,
      'note': instance.note,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
