
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  // user: {
  //       type: Schema.Types.ObjectId,
  //       ref: 'User'
  //   },
  //   apartment: {
  //       type: Schema.Types.ObjectId,
  //       ref: 'Apartment'
  //   },
  //   title: {
  //       type: String,
  //       required: true
  //   },
  //   content: {
  //       type: String,
  //       required: true
  //   },
  //   type: {
  //       type: String,
  //   },
  //   isRead: {
  //       type: Boolean,
  //       default: false
  //   }
  String? id;
  String? user;
  String? apartment;
  String? title;
  String? content;
  String? type;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.user,
    this.apartment,
    this.title,
    this.content,
    this.type,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

}