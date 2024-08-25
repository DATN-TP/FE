// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      apartment: json['apartment'] as String?,
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      paymentMethod: json['paymentMethod'] as String,
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      paymentBy: json['paymentBy'] as String?,
      note: json['note'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
      paid: json['paid'] as bool? ?? false,
    );

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      'apartment': instance.apartment,
      'service': instance.service,
      'amount': instance.amount,
      'status': instance.status,
      'date': instance.date.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'paymentBy': instance.paymentBy,
      'note': instance.note,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'paid': instance.paid,
    };
