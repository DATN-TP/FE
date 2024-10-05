// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      apartment: json['apartment'] == null
          ? null
          : Apartment.fromJson(json['apartment'] as Map<String, dynamic>),
      name: json['name'] as String?,
      type: json['type'] as String?,
      color: json['color'] as String?,
      brand: json['brand'] as String?,
      licensePlate: json['licensePlate'] as String?,
      parking: json['parking'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
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

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'owner': instance.owner,
      'apartment': instance.apartment,
      'name': instance.name,
      'type': instance.type,
      'color': instance.color,
      'brand': instance.brand,
      'licensePlate': instance.licensePlate,
      'parking': instance.parking,
      'image': instance.image,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
