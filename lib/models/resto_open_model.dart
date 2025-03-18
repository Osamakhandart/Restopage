// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

RestaurantModel restaurantModelFromJson(String str) => RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) => json.encode(data.toJson());

class RestaurantModel {
  String id;
  String restId;
  List<List<Hour>> openingHours;
  List<List<Hour>> deliveryHours;
  List<List<Hour>> pickupHours;
  Holidays holidays;
  IrregularOpenings irregularOpenings;

  RestaurantModel({
    required this.id,
    required this.restId,
    required this.openingHours,
    required this.deliveryHours,
    required this.pickupHours,
    required this.holidays,
    required this.irregularOpenings,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    id: json["id"].toString(),
    restId: json["rest_id"].toString(),
    openingHours: List<List<Hour>>.from(json["opening_hours"].map((x) => List<Hour>.from(x.map((x) => Hour.fromJson(x))))),
    deliveryHours: List<List<Hour>>.from(json["delivery_hours"].map((x) => List<Hour>.from(x.map((x) => Hour.fromJson(x))))),
    pickupHours: List<List<Hour>>.from(json["pickup_hours"].map((x) => List<Hour>.from(x.map((x) => Hour.fromJson(x))))),
    holidays: Holidays.fromJson(json["holidays"]),
    irregularOpenings: IrregularOpenings.fromJson(json["irregular_openings"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rest_id": restId,
    "opening_hours": List<dynamic>.from(openingHours.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "delivery_hours": List<dynamic>.from(deliveryHours.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "pickup_hours": List<dynamic>.from(pickupHours.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "holidays": holidays.toJson(),
    "irregular_openings": irregularOpenings.toJson(),
  };
}

class Hour {
  String start;
  String end;

  Hour({
    required this.start,
    required this.end,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
    start: json["start"]== "12:00" ? "11:59":json["start"],
    end: json["end"]== "12:00" ? "11:59":json["end"],
  );

  Map<String, dynamic> toJson() => {
    "start": start   ,
    "end": end== "12:00" ? "12:01":end ,
  };
}

class Holidays {
  List<String> name;
  List<String> dateStart;
  List<String> dateEnd;

  Holidays({
    required this.name,
    required this.dateStart,
    required this.dateEnd,
  });

  factory Holidays.fromJson(Map<String, dynamic> json) => Holidays(
    name: List<String>.from(json["name"].map((x) => x)),
    dateStart: List<String>.from(json["dateStart"].map((x) => x)),
    dateEnd: List<String>.from(json["dateEnd"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": List<dynamic>.from(name.map((x) => x)),
    "dateStart": List<dynamic>.from(dateStart.map((x) => x)),
    "dateEnd": List<dynamic>.from(dateEnd.map((x) => x)),
  };
}

class IrregularOpenings {
  List<String> name;
  List<String> date;
  List<String> timeStart;
  List<String> timeEnd;

  IrregularOpenings({
    required this.name,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
  });

  factory IrregularOpenings.fromJson(Map<String, dynamic> json) => IrregularOpenings(
    name: List<String>.from(json["name"].map((x) => x)),
    date: List<String>.from(json["date"].map((x) => x)),
    timeStart: List<String>.from(json["timeStart"].map((x) => x)),
    timeEnd: List<String>.from(json["timeEnd"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": List<dynamic>.from(name.map((x) => x)),
    "date": List<dynamic>.from(date.map((x) => x)),
    "timeStart": List<dynamic>.from(timeStart.map((x) => x)),
    "timeEnd": List<dynamic>.from(timeEnd.map((x) => x)),
  };
}
