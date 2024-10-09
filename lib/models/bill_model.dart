
import 'package:ResiEasy/models/detail_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class Bill {
  // apartment: { type: Schema.Types.ObjectId, ref: 'Apartment' },
  //   price: { type: Number },
  //   electric: { type: Number },
  //   water: { type: Number },
  //   service: [{ type: Schema.Types.ObjectId, ref: 'DetailService' }],
  //   status: { type: String, enum: ['pending', 'paid'], default: 'pending' },
  //   date: { type: Date, default: Date.now },
  //   paymentMethod: { type: String, enum: ['cash', 'transfer'] },
  //   paymentDate: { type: Date },
  //   paymentBy: { type: Schema.Types.ObjectId, ref: 'User' },
  //   total: { type: Number },
  //   note: { type: String },
  //   createAt: { type: Date, default: Date.now },
  //   updateAt: { type: Date, default: Date.now },
  //   deleteAt: { type: Date },

  String? id;
  String? apartment;
  double? price;
  double? electric;
  double? water;
  List<DetailService>? service;
  String? status;
  DateTime? date;
  String? paymentMethod;
  DateTime? paymentDate;
  String? paymentBy;
  double? total;
  String? note;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  Bill({
    this.id,
    this.apartment,
    this.price,
    this.electric,
    this.water,
    this.service,
    this.status,
    this.date,
    this.paymentMethod,
    this.paymentDate,
    this.paymentBy,
    this.total,
    this.note,
    this.createAt,
    this.updateAt,
    this.deleteAt,
  });


  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);
  Map<String, dynamic> toJson() => _$BillToJson(this);
}

