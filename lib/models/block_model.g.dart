// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Block _$BlockFromJson(Map<String, dynamic> json) => Block(
      name: json['name'] as String,
      floors: (json['floors'] as List<dynamic>?)
          ?.map((e) => Floor.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalFloors: (json['totalFloors'] as num?)?.toInt(),
      totalApartments: (json['totalApartments'] as num?)?.toInt(),
      totalResidents: (json['totalResidents'] as num?)?.toInt(),
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
    );

Map<String, dynamic> _$BlockToJson(Block instance) => <String, dynamic>{
      'name': instance.name,
      'floors': instance.floors,
      'totalFloors': instance.totalFloors,
      'totalApartments': instance.totalApartments,
      'totalResidents': instance.totalResidents,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      name: json['name'] as String,
      block: json['block'] == null
          ? null
          : Block.fromJson(json['block'] as Map<String, dynamic>),
      apartments: (json['apartments'] as List<dynamic>?)
          ?.map((e) => Apartment.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalApartments: (json['totalApartments'] as num?)?.toInt(),
      totalResidents: (json['totalResidents'] as num?)?.toInt(),
      manager: json['manager'] == null
          ? null
          : User.fromJson(json['manager'] as Map<String, dynamic>),
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'name': instance.name,
      'block': instance.block,
      'apartments': instance.apartments,
      'totalApartments': instance.totalApartments,
      'totalResidents': instance.totalResidents,
      'manager': instance.manager,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
