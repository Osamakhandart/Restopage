// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  String id;
  String restId;
  OrderType? type;
  Status? status;
  DateTime date;
  String mobileNotify;
  String subtitle;
  String remainingTime;
  String remainingTimeAfterAccept;
  Specification? specification;
  String title;

  OrderModel({
    required this.id,
    required this.restId,
    this.type,
    this.status,
    required this.date,
    required this.mobileNotify,
    required this.subtitle,
    required this.remainingTime,
    required this.remainingTimeAfterAccept,
    this.specification,
    required this.title,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        restId: json["rest_id"],
        type: typeValues.map[json["TYPE"]],
        status: statusValues.map[json["STATUS"]],
        date: DateTime.parse(json["DATE"]).toLocal(),
        mobileNotify: json["mobile_notify"],
        subtitle: convertDateTimeFormat(json["subtitle"]),
        remainingTime: json["remaining_time"].toString(),
        remainingTimeAfterAccept:
            json["remaining_time_after_accept"].toString(),
        specification: specificationValues.map[json["specification"]],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_id": restId,
        "TYPE": typeValues.reverse[type],
        "STATUS": statusValues.reverse[status],
        "DATE": date.toIso8601String(),
        "mobile_notify": mobileNotify,
        "subtitle": subtitle,
        "remaining_time": remainingTime,
        "remaining_time_after_accept": remainingTimeAfterAccept,
        "specification": specificationValues.reverse[specification],
        "title": title,
      };
  static String convertDateTimeFormat(String dateTimeStr) {
    try {
      List<String> parts = dateTimeStr.split(' ');
      if (parts.length != 2) {
        throw FormatException('Invalid datetime format');
      }

      DateTime dateTime = DateFormat('MM/dd/yyyy HH:mm').parse(dateTimeStr);

      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      String formattedTime = DateFormat('HH:mm').format(dateTime);

      return "$formattedDate $formattedTime";
    } catch (e) {
      // If parsing fails, return the original string
      return dateTimeStr;
    }
  }
}

enum Specification { PRE, REAL, VIRTUAL }

final specificationValues = EnumValues({
  "pre": Specification.PRE,
  "real": Specification.REAL,
  "virtual": Specification.VIRTUAL
});

enum Status { ACCEPTED, CANCELED, PENDING }

final statusValues = EnumValues({
  "accepted": Status.ACCEPTED,
  "canceled": Status.CANCELED,
  "pending": Status.PENDING
});

enum OrderType { DELIVERY, PICKUP, RESERVATION }

final typeValues = EnumValues({
  "delivery": OrderType.DELIVERY,
  "pickup": OrderType.PICKUP,
  "reservation": OrderType.RESERVATION
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
