// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      role: json['role'] as String?,
      address: json['address'] as String? ?? '',
      apartments: (json['apartments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      houseHoldHead: json['houseHoldHead'] as bool? ?? false,
      relationship: json['relationship'] as String? ?? 'Người thân',
      position: json['position'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
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

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'dob': instance.dob?.toIso8601String(),
      'role': instance.role,
      'address': instance.address,
      'apartments': instance.apartments,
      'houseHoldHead': instance.houseHoldHead,
      'relationship': instance.relationship,
      'position': instance.position,
      'avatar': instance.avatar,
      'refreshToken': instance.refreshToken,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'deleteAt': instance.deleteAt?.toIso8601String(),
    };
