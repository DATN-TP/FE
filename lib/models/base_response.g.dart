// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      data: json['data'] == null
          ? null
          : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      messageDetail: (json['messageDetail'] as List<dynamic>?)
          ?.map(
              (e) => MessageDetailResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'messageDetail': instance.messageDetail,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      totalMoney: (json['totalMoney'] as num?)?.toInt(),
      totalSuccess: (json['totalSuccess'] as num?)?.toInt(),
      totalInProgress: (json['totalInProgress'] as num?)?.toInt(),
      result: json['result'] as bool?,
      msgCode: json['msgCode'] as String?,
      msgDesc: json['msgDesc'] as String?,
      data: json['data'],
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'totalMoney': instance.totalMoney,
      'totalSuccess': instance.totalSuccess,
      'totalInProgress': instance.totalInProgress,
      'result': instance.result,
      'msgCode': instance.msgCode,
      'msgDesc': instance.msgDesc,
      'data': instance.data,
      'pagination': instance.pagination,
    };

MessageDetailResponse _$MessageDetailResponseFromJson(
        Map<String, dynamic> json) =>
    MessageDetailResponse(
      result: json['result'] as bool?,
      msgCode: json['msgCode'] as String?,
      msgDesc: json['msgDesc'] as String?,
    );

Map<String, dynamic> _$MessageDetailResponseToJson(
        MessageDetailResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'msgCode': instance.msgCode,
      'msgDesc': instance.msgDesc,
    };
