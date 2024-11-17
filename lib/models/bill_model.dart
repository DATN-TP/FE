
import 'package:ResiEasy/models/detail_service.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bill_model.g.dart';

@JsonSerializable()
class Bill {
  //  apartment: { type: Schema.Types.ObjectId, ref: 'Apartment' },
  //   resident: { type: String},
  //   price: { type: Number },
  //   electric: { type: Number },
  //   water: { type: Number },
  //   service: [{ type: Schema.Types.ObjectId, ref: 'DetailService' }],
  //   listVehicle: [{
  //       type: { type: String },
  //       price: { type: Number },
  //       quantity: { type: Number },
  //       total: { type: Number },
  //   }],
  //   oldElectricNumber: { type: Number, default: 0 },
  //   oldWaterNumber: { type: Number, default: 0 },
  //   newElectricNumber: { type: Number, default: 0 },
  //   newWaterNumber: { type: Number, default: 0 },
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
  String? resident;
  double? price;
  double? electric;
  double? water;
  List<DetailService>? service;
  List<VehicleBill>? listVehicle;
  double? oldElectricNumber;
  double? oldWaterNumber;
  double? newElectricNumber;
  double? newWaterNumber;
  double? managementFee;
  double? ePrice;
  double? wPrice;
  double?managementPrice;
  String? status;
  DateTime? date;
  String? paymentMethod;
  DateTime? paymentDate;
  User? paymentBy;
  double? total;
  String? note;
  DateTime? createAt;
  DateTime? updateAt;
  DateTime? deleteAt;

  Bill({
    this.id,
    this.apartment,
    this.resident,
    this.price,
    this.electric,
    this.water,
    this.service,
    this.listVehicle,
    this.oldElectricNumber,
    this.oldWaterNumber,
    this.newElectricNumber,
    this.managementFee,
    this.ePrice,
    this.wPrice,
    this.managementPrice,
    this.newWaterNumber,
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

@JsonSerializable()
class VehicleBill {
  String? type;
  double? price;
  double? quantity;
  double? total;

  VehicleBill({
    this.type,
    this.price,
    this.quantity,
    this.total,
  });

  factory VehicleBill.fromJson(Map<String, dynamic> json) => _$VehicleBillFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleBillToJson(this);
}

