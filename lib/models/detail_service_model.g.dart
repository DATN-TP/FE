// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailService _$DetailServiceFromJson(Map<String, dynamic> json) =>
    DetailService(
      service: json['service'] == null
          ? null
          : Service.fromJson(json['service'] as Map<String, dynamic>),
      registerAt: json['registerAt'] == null
          ? null
          : DateTime.parse(json['registerAt'] as String),
      registerBy: json['registerBy'] == null
          ? null
          : User.fromJson(json['registerBy'] as Map<String, dynamic>),
      apartment: json['apartment'] == null
          ? null
          : Apartment.fromJson(json['apartment'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
      paid: json['paid'] as bool?,
      note: json['note'] as String?,
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
    );

Map<String, dynamic> _$DetailServiceToJson(DetailService instance) =>
    <String, dynamic>{
      'service': instance.service,
      'registerAt': instance.registerAt?.toIso8601String(),
      'registerBy': instance.registerBy,
      'apartment': instance.apartment,
      'quantity': instance.quantity,
      'paid': instance.paid,
      'note': instance.note,
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
