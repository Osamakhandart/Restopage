import 'package:resto_page/models/resto_open_model.dart';

class RestaurantTimingModel {
  final String day;
    List<Hour> timing;

  RestaurantTimingModel({required this.day, required this.timing});


}

// class RestaurantDayModel {
//   final String monday;
//   final String tuesday;
//   final String wednesday;
//   final String thursday;
//   final String friday;
//   final String saturday;
//   final String sunday;
//
//   RestaurantDayModel(
//       {required this.friday,
//       required this.monday,
//       required this.saturday,
//       required this.sunday,
//       required this.thursday,
//       required this.tuesday,
//       required this.wednesday});
// }
