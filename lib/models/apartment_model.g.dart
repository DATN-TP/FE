// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Apartment _$ApartmentFromJson(Map<String, dynamic> json) => Apartment(
      name: json['name'] as String,
      floor: json['floor'] as String?,
      block: json['block'] as String?,
      totalResidents: (json['totalResidents'] as num?)?.toInt() ?? 0,
      totalVehicle: (json['totalVehicle'] as num?)?.toInt() ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 3000000,
      area: (json['area'] as num?)?.toDouble() ?? 30,
      rooms: (json['rooms'] as num?)?.toInt() ?? 2,
      status: json['status'] as String? ?? 'available',
      paid: json['paid'] as bool? ?? true,
      note: json['note'] as String?,
      createAt: DateTime.parse(json['createAt'] as String),
      startAt: json['startAt'] == null
          ? null
          : DateTime.parse(json['startAt'] as String),
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ApartmentToJson(Apartment instance) => <String, dynamic>{
      'name': instance.name,
      'floor': instance.floor,
      'block': instance.block,
      'totalResidents': instance.totalResidents,
      'totalVehicle': instance.totalVehicle,
      'price': instance.price,
      'area': instance.area,
      'rooms': instance.rooms,
      'status': instance.status,
      'paid': instance.paid,
      'note': instance.note,
      'createAt': instance.createAt.toIso8601String(),
      'startAt': instance.startAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'image': instance.image,
    };
