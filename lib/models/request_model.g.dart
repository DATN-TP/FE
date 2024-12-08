// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      owner: json['owner'] == null
          ? null
          : User.fromJson(json['owner'] as Map<String, dynamic>),
      apartment: json['apartment'] == null
          ? null
          : Apartment.fromJson(json['apartment'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      status: (json['status'] as num).toInt(),
      createAt: DateTime.parse(json['createAt'] as String),
      updateAt: json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
      deleteAt: json['deleteAt'] == null
          ? null
          : DateTime.parse(json['deleteAt'] as String),
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      reason: json['reason'] as String? ?? '',
    )..type = json['type'] as String?;

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'owner': instance.owner,
      'apartment': instance.apartment,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
      'image': instance.image,
      'reason': instance.reason,
    };
