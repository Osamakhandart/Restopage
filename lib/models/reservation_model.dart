// To parse this JSON data, do
//
//     final reservationModel = reservationModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

ReservationModel reservationModelFromJson(String str) =>
    ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) =>
    json.encode(data.toJson());

class ReservationModel {
  String id;
  String restId;
  String numberOfPeople;
  String date;
  String time;
  String telephone;
  String email;
  String firstName;
  String lastName;
  String status;
  DateTime createdAt;
  String remark;
  String reservationSpecification;
  String reservationMobileNotify;

  ReservationModel({
    required this.id,
    required this.restId,
    required this.numberOfPeople,
    required this.date,
    required this.time,
    required this.telephone,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.createdAt,
    required this.remark,
    required this.reservationSpecification,
    required this.reservationMobileNotify,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      ReservationModel(
        id: json["id"],
        restId: json["rest_id"],
        numberOfPeople: json["number_of_people"],
        date: convertDateTimeFormat(json["date"]),
        time: json["time"],
        telephone: json["telephone"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        remark: json["remark"],
        reservationSpecification: json["reservation_specification"],
        reservationMobileNotify: json["reservation_mobile_notify"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_id": restId,
        "number_of_people": numberOfPeople,
        "date": date,
        "time": time,
        "telephone": telephone,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "remark": remark,
        "reservation_specification": reservationSpecification,
        "reservation_mobile_notify": reservationMobileNotify,
      };

  static String convertDateTimeFormat(String dateTimeStr) {
    DateTime dateTime;
    DateFormat inputFormat;

    // Split the string into date and time parts if time is present
    List<String> parts = dateTimeStr.split(' ');
    List<String> dateParts =
        parts[0].contains('-') ? parts[0].split('-') : parts[0].split('/');
    String separator = parts[0].contains('-') ? '-' : '/';

    // Determine the date format based on the order of date parts and the separator used
    if (dateParts.length == 3) {
      if (dateParts[0].length == 4) {
        // Format starts with year: "yyyy-MM-dd" or "yyyy/MM/dd"
        inputFormat = DateFormat('yyyy${separator}MM${separator}dd');
      } else if (dateParts[2].length == 4) {
        // Format ends with year: "dd-MM-yyyy" or "MM-dd-yyyy", assumed based on separator
        inputFormat = separator == '/'
            ? DateFormat('MM${separator}dd${separator}yyyy')
            : DateFormat('dd${separator}MM${separator}yyyy');
      } else {
        throw FormatException('Ambiguous or unsupported date format');
      }
    } else {
      throw FormatException('Unsupported datetime format');
    }

    // Determine time format if time is provided
    if (parts.length == 2 && !parts[1].isEmpty) {
      List<String> timeParts = parts[1].split(':');
      String timeFormat = timeParts.length == 3 ? 'HH:mm:ss' : 'HH:mm';
      inputFormat = DateFormat('${inputFormat.pattern} $timeFormat');
    }

    // Parse the date using the determined format
    dateTime = inputFormat.parse(dateTimeStr);

    // Format the DateTime object to desired output format
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedTime = parts.length == 2 && !parts[1].isEmpty
        ? DateFormat('HH:mm').format(dateTime)
        : "";

    // Return combined formatted date and time if time is present
    return formattedTime.isEmpty
        ? formattedDate
        : "$formattedDate $formattedTime";
  }
}
