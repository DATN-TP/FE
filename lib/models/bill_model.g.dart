// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) => Bill(
      id: json['_id'] as String?,
      apartment: json['apartment'] as String?,
      resident: json['resident'] as String?,
      price: (json['price'] as num?)?.toInt(),
      electric: (json['electric'] as num?)?.toInt(),
      water: (json['water'] as num?)?.toInt(),
      service: (json['service'] as List<dynamic>?)
          ?.map((e) => DetailService.fromJson(e as Map<String, dynamic>))
          .toList(),
      listVehicle: (json['listVehicle'] as List<dynamic>?)
          ?.map((e) => VehicleBill.fromJson(e as Map<String, dynamic>))
          .toList(),
      oldElectricNumber: (json['oldElectricNumber'] as num?)?.toInt(),
      oldWaterNumber: (json['oldWaterNumber'] as num?)?.toInt(),
      newElectricNumber: (json['newElectricNumber'] as num?)?.toInt(),
      managementFee: (json['managementFee'] as num?)?.toInt(),
      ePrice: (json['ePrice'] as num?)?.toInt(),
      eQuota: (json['eQuota'] as num?)?.toInt(),
      eQuota1: (json['eQuota1'] as num?)?.toInt(),
      eQuota2: (json['eQuota2'] as num?)?.toInt(),
      eQuota3: (json['eQuota3'] as num?)?.toInt(),
      wQuota: (json['wQuota'] as num?)?.toInt(),
      wQuota1: (json['wQuota1'] as num?)?.toInt(),
      wQuota2: (json['wQuota2'] as num?)?.toInt(),
      wQuota3: (json['wQuota3'] as num?)?.toInt(),
      wPrice: (json['wPrice'] as num?)?.toInt(),
      managementPrice: (json['managementPrice'] as num?)?.toInt(),
      newWaterNumber: (json['newWaterNumber'] as num?)?.toInt(),
      status: json['status'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      paymentMethod: json['paymentMethod'] as String?,
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      paymentBy: json['paymentBy'] == null
          ? null
          : User.fromJson(json['paymentBy'] as Map<String, dynamic>),
      total: (json['total'] as num?)?.toInt(),
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

Map<String, dynamic> _$BillToJson(Bill instance) => <String, dynamic>{
      '_id': instance.id,
      'apartment': instance.apartment,
      'resident': instance.resident,
      'price': instance.price,
      'electric': instance.electric,
      'water': instance.water,
      'service': instance.service,
      'listVehicle': instance.listVehicle,
      'oldElectricNumber': instance.oldElectricNumber,
      'oldWaterNumber': instance.oldWaterNumber,
      'newElectricNumber': instance.newElectricNumber,
      'newWaterNumber': instance.newWaterNumber,
      'managementFee': instance.managementFee,
      'ePrice': instance.ePrice,
      'eQuota': instance.eQuota,
      'eQuota1': instance.eQuota1,
      'eQuota2': instance.eQuota2,
      'eQuota3': instance.eQuota3,
      'wQuota': instance.wQuota,
      'wQuota1': instance.wQuota1,
      'wQuota2': instance.wQuota2,
      'wQuota3': instance.wQuota3,
      'wPrice': instance.wPrice,
      'managementPrice': instance.managementPrice,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'paymentBy': instance.paymentBy,
      'total': instance.total,
      'note': instance.note,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };

VehicleBill _$VehicleBillFromJson(Map<String, dynamic> json) => VehicleBill(
      type: json['type'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VehicleBillToJson(VehicleBill instance) =>
    <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
      'quantity': instance.quantity,
      'total': instance.total,
    };
