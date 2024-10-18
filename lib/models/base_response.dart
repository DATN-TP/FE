// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ResiEasy/extension.dart';
import 'package:ResiEasy/models/pagination.dart';
import 'package:json_annotation/json_annotation.dart';


part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final DataResponse? data;
  final String? message;
  final List<MessageDetailResponse>? messageDetail;

  BaseResponse({
    required this.data,
    this.message,
    this.messageDetail,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
  bool get isSuccess {
    return message!.isEmptyOrNull() || message!.toLowerCase() == "success";
  }

  String get messageResponse {
    return messageDetail?.first.msgDesc ?? message ?? "Lỗi không xác định";
  }

  List<T> parseList<T>(T Function(Map<String, dynamic> map) jsonConvertor) {
    List items = data?.data ?? [];
    return items.map((element) {
      return jsonConvertor(element);
    }).toList();
  }

  T parse<T>(T Function(Map<String, dynamic> map) jsonConvertor) {
    if (data?.data == null) {
      // ignore: null_check_always_fails
      return null!;
    } else {
      return jsonConvertor(data!.data);
    }
  }

  BaseResponse copyWith({
    DataResponse? data,
    String? message,
    List<MessageDetailResponse>? messageDetail,
  }) {
    return BaseResponse(
      data: data ?? this.data,
      message: message ?? this.message,
      messageDetail: messageDetail ?? this.messageDetail,
    );
  }
}

@JsonSerializable()
class DataResponse {
  int? totalMoney;
  int? totalSuccess;
  int? totalInProgress;
  bool? result;
  String? msgCode;
  String? msgDesc;
  dynamic data;
  Pagination? pagination;
  DataResponse(
    
    {this.totalMoney, this.totalSuccess, this.totalInProgress,required this.result, this.msgCode, this.msgDesc, this.data, this.pagination});

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  DataResponse copyWith({
    int? totalMoney,
    int? totalSuccess,
    int? totalInProgress,
    bool? result,
    String? msgCode,
    String? msgDesc,
    dynamic data,
    Pagination? pagination,
  }) {
    return DataResponse(
      totalMoney: totalMoney,
      totalSuccess: totalSuccess,
      totalInProgress: totalInProgress,
      result: result ?? this.result,
      msgCode: msgCode ?? this.msgCode,
      msgDesc: msgDesc ?? this.msgDesc,
      data: data ?? this.data,
      pagination: pagination ?? this.pagination,
    );
  }
}

@JsonSerializable()
class MessageDetailResponse {
  bool? result;
  String? msgCode;
  String? msgDesc;
  MessageDetailResponse({
    required this.result,
    this.msgCode,
    this.msgDesc,
  });

  factory MessageDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDetailResponseToJson(this);
}
