import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resto_page/api/repo/auth_repo.dart';
import 'package:resto_page/api/repo/others_repo.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/models/order_model.dart';
import 'package:resto_page/models/term_model.dart';
import 'package:resto_page/utils/shared_prefs.dart';

import 'package:resto_page/api/repo/order_repo.dart';
import 'package:resto_page/models/about_model.dart';
import 'package:resto_page/models/response_item.dart';
import 'package:resto_page/models/resto_open_model.dart';
import 'package:resto_page/models/resturant_timing_model.dart';
import 'package:resto_page/theme/app_layout.dart';
import 'package:resto_page/utils/extension.dart';

bool? pendingOrdersRemaining;
DateTime? pendingOrdersCheckDateTime;

class HomeScreenController extends GetxController with WidgetsBindingObserver {
  bool isDrawerOpen = false;
  RxBool isLoading = false.obs;
  RxBool logoutLoader = false.obs;
  bool appIsOpen = false;

  final preferences = SharedPreference();
  bool openingHasBreak = false;
  bool reservationHasBreak = false;
  bool deliveryHasBreak = false;
  int date = 0;
  String day = "Monday";
  String? dropdownValue;
  int currentTab = 0;
  List<OrderModel> viewAllList = [];
  List<OrderModel> pendingList = [];
  List<OrderModel> acceptedList = [];
  List<OrderModel> rejectedList = [];

  List<RestaurantTimingModel> openingHourList = [
    RestaurantTimingModel(day: "Monday", timing: []),
    RestaurantTimingModel(day: "Tuesday", timing: []),
    RestaurantTimingModel(day: "Wednesday", timing: []),
    RestaurantTimingModel(day: "Thursday", timing: []),
    RestaurantTimingModel(day: "Friday", timing: []),
    RestaurantTimingModel(day: "Saturday", timing: []),
    RestaurantTimingModel(day: "Sunday", timing: []),
  ];

  List<RestaurantTimingModel> deliveryHourList = [
    RestaurantTimingModel(day: "Monday", timing: []),
    RestaurantTimingModel(day: "Tuesday", timing: []),
    RestaurantTimingModel(day: "Wednesday", timing: []),
    RestaurantTimingModel(day: "Thursday", timing: []),
    RestaurantTimingModel(day: "Friday", timing: []),
    RestaurantTimingModel(day: "Saturday", timing: []),
    RestaurantTimingModel(day: "Sunday", timing: []),
  ];

  List<RestaurantTimingModel> pickUpHourList = [
    RestaurantTimingModel(day: "Monday", timing: []),
    RestaurantTimingModel(day: "Tuesday", timing: []),
    RestaurantTimingModel(day: "Wednesday", timing: []),
    RestaurantTimingModel(day: "Thursday", timing: []),
    RestaurantTimingModel(day: "Friday", timing: []),
    RestaurantTimingModel(day: "Saturday", timing: []),
    RestaurantTimingModel(day: "Sunday", timing: []),
  ];

  /// OPENING HOUR
  TimeOfDay? firstOpeningTime;
  TimeOfDay? firstOpeningEndTime;
  TimeOfDay? secondOpeningStartTime;
  TimeOfDay? secondOpeningEndTime;

  /// DELIVERY HOUR
  TimeOfDay? firstDeliverTime;
  TimeOfDay? firstDeliverEndTime;
  TimeOfDay? secondDeliverStartTime;
  TimeOfDay? secondDeliverEndTime;

  /// PICKUP HOUR
  TimeOfDay? firstPickUpTime;
  TimeOfDay? firstPickUpEndTime;
  TimeOfDay? secondPickUpStartTime;
  TimeOfDay? secondPickUpEndTime;

  ///other models
  AboutModel? about;
  TermModel? term;

  ///date formater

  // String convertDateTimeFormat(String dateTimeStr) {
  //   try {
  //     // Split the date and time parts
  //     List<String> parts = dateTimeStr.split(' ');
  //     if (parts.length != 2) {
  //       throw FormatException('Invalid datetime format');
  //     }
  //
  //     // Parse the date string in M/D/Y format
  //     DateTime dateTime = DateFormat('MM/dd/yyyy HH:mm').parse(dateTimeStr);
  //
  //     // Format the DateTime object to D/M/Y format for the date and keep time as is
  //     String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  //     String formattedTime = DateFormat('HH:mm').format(dateTime);
  //
  //     // Combine the formatted date and original time
  //     return "$formattedDate $formattedTime";
  //   } catch (e) {
  //     // If parsing fails, return the original string
  //     return dateTimeStr;
  //   }
  // }
  onDropDownChange(v) {
    dropdownValue = v;

    update();
  }

  setOrderLength(List listName) {
    return listName.isNotEmpty
        ? dropdownValue! != 'see All'
            ? listName.length >= int.parse(dropdownValue!)
                ? int.parse(dropdownValue!)
                : listName.length
            : listName.length
        : listName.length;
  }

  setDropDownOptions({required tabNo}) {
    dropdownOptions.clear();
    if (tabNo == 0) {
      _generateDropdownOptions(viewAllList.length);
    } else if (tabNo == 1) {
      _generateDropdownOptions(pendingList.length);
    } else if (tabNo == 2) {
      _generateDropdownOptions(acceptedList.length);
    } else if (tabNo == 3) {
      _generateDropdownOptions(rejectedList.length);
    }
  }

  List<String> dropdownOptions = [];
  void _generateDropdownOptions(totalOrders) {
    dropdownOptions.add(1.toString());
    if (totalOrders < 10) {
      dropdownOptions.add('see All');
      dropdownValue = 'see All';
    } else {
      // Determine reasonable increments based on the total number of orders
      if (totalOrders >= 10) {
        dropdownOptions.add(10.toString());
        dropdownValue = 10.toString();
      }
      if (totalOrders >= 50) {
        dropdownOptions.add(50.toString());
      }
      if (totalOrders >= 100) {
        dropdownOptions.add(100.toString());
      }
      if (totalOrders >= 200) {
        dropdownOptions.add(200.toString());
      }
      if (totalOrders >= 500) {
        dropdownOptions.add(500.toString());
      }
      dropdownOptions.add('see All');
    }
    // Add 'All' option if it's not included yet

    print(totalOrders);
  }

  getViewAll() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await OrderRepo.getOrderAndReservation();
    try {
      if (result.status) {
        if (result.data != null) {
          List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          viewAllList = order;
    

          setDropDownOptions(tabNo: 0);
          if (viewAllList.any((element) => element.status == Status.PENDING)) {
            pendingOrdersRemaining = true;
          }
          isLoading.value = false;
          update();
        }
      } else {
        showBottomSnackBar(result.message ?? "");
        isLoading.value = false;
      }
    } catch (e) {
     
      isLoading.value = false;
    }
    update();
  }

  getPending() async {
    isLoading.value = true;
    ResponseItem result;
    result = await OrderRepo.getAllPending();
    try {
      if (result.status) {
        if (result.data != null) {
          List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));

          pendingList = order;
          setDropDownOptions(tabNo: 1);
          isLoading.value = false;
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  getAccepted() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await OrderRepo.getAllAccepted();
    try {
      if (result.status) {
        if (result.data != null) {
          List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          acceptedList = order;
          setDropDownOptions(tabNo: 2);
          isLoading.value = false;
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  getRejected() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await OrderRepo.getAllRejected();
    try {
      if (result.status) {
        if (result.data != null) {
          List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          rejectedList = order;
          setDropDownOptions(tabNo: 3);
          isLoading.value = false;
          update();
        }
      } else {
        // showAppSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  getAbout() async {
    ResponseItem result;
    result = (await OthersRepo.getAboutUs())!;
    try {
      if (result.data != null) {
        about = aboutModelFromJson(result.data);
  
        print('about');
        update();
      } else {}
    } catch (e) {}
    update();
  }

  getTerm() async {
    ResponseItem result;
    result = (await OthersRepo.getTerm())!;
    try {
      if (result.data != null) {
        term = termModelFromJson(result.data);
        update();
      } else {}
    } catch (e) {}
    update();
  }

  getOpenTime() async {
    isLoading.value = true;
    ResponseItem result;
    result = await OrderRepo.getOpenTime();
    try {
      if (result.status) {
        if (result.data != null) {
          try {
            Map<String, dynamic> data = result.data;
            data.forEach((key, value) {
              try {
                data[key] = jsonDecode(value);
              } catch (e) {
                data[key] = value;
              }
            });

            RestaurantModel restaurantModel = RestaurantModel.fromJson(data);

            for (int i = 0; i < restaurantModel.openingHours.length; i++) {
              openingHourList[i].timing = restaurantModel.openingHours[i];
            }
            for (int i = 0; i < restaurantModel.deliveryHours.length; i++) {
              deliveryHourList[i].timing = restaurantModel.deliveryHours[i];
            }
            for (int i = 0; i < restaurantModel.pickupHours.length; i++) {
              pickUpHourList[i].timing = restaurantModel.pickupHours[i];
            }

            openingHasBreak = openingHourList[date].timing.length > 1;
            reservationHasBreak = deliveryHourList[date].timing.length > 1;
            deliveryHasBreak = pickUpHourList[date].timing.length > 1;

            /// OPENING HOUR
            DateTime _openingStartDate = DateFormat("hh:mm")
                .parse(openingHourList[date].timing.first.start);
            firstOpeningTime = TimeOfDay(
                hour: _openingStartDate.hour, minute: _openingStartDate.minute);
            DateTime _openingEndDate = DateFormat("hh:mm")
                .parse(openingHourList[date].timing.first.end);
            firstOpeningEndTime = TimeOfDay(
                hour: _openingEndDate.hour, minute: _openingEndDate.minute);

            DateTime _secondOpeningStartDate = DateFormat("hh:mm")
                .parse(openingHourList[date].timing.last.start);
            secondOpeningStartTime = TimeOfDay(
                hour: _secondOpeningStartDate.hour,
                minute: _secondOpeningStartDate.minute);
            DateTime _secondOpeningEndDate = DateFormat("hh:mm")
                .parse(openingHourList[date].timing.last.end);
            secondOpeningEndTime = TimeOfDay(
                hour: _secondOpeningEndDate.hour,
                minute: _secondOpeningEndDate.minute);

         

            /// DELIVERY HOUR
            DateTime _deliverStartDate = DateFormat("hh:mm")
                .parse(deliveryHourList[date].timing.first.start);
            firstDeliverTime = TimeOfDay(
                hour: _deliverStartDate.hour, minute: _deliverStartDate.minute);

            DateTime _deliverEndDate = DateFormat("hh:mm")
                .parse(deliveryHourList[date].timing.first.end);
            firstDeliverEndTime = TimeOfDay(
                hour: _deliverEndDate.hour, minute: _deliverEndDate.minute);

            DateTime _secondDeliverStartDate = DateFormat("hh:mm")
                .parse(deliveryHourList[date].timing.last.start);
            secondDeliverStartTime = TimeOfDay(
                hour: _secondDeliverStartDate.hour,
                minute: _secondDeliverStartDate.minute);

            DateTime _secondDeliverEndDate = DateFormat("hh:mm")
                .parse(deliveryHourList[date].timing.last.end);
            secondDeliverEndTime = TimeOfDay(
                hour: _secondDeliverEndDate.hour,
                minute: _secondDeliverEndDate.minute);

            /// PICK UP HOUR
            DateTime _pickUpStartDate = DateFormat("hh:mm")
                .parse(pickUpHourList[date].timing.first.start);
            firstPickUpTime = TimeOfDay(
                hour: _pickUpStartDate.hour, minute: _pickUpStartDate.minute);

            DateTime _pickUpEndDate = DateFormat("hh:mm")
                .parse(pickUpHourList[date].timing.first.end);
            firstPickUpEndTime = TimeOfDay(
                hour: _pickUpEndDate.hour, minute: _pickUpEndDate.minute);

            DateTime _secondPickUpStartDate = DateFormat("hh:mm")
                .parse(pickUpHourList[date].timing.last.start);
            secondPickUpStartTime = TimeOfDay(
                hour: _secondPickUpStartDate.hour,
                minute: _secondPickUpStartDate.minute);

            DateTime _secondPickUpEndDate =
                DateFormat("hh:mm").parse(pickUpHourList[date].timing.last.end);
            secondPickUpEndTime = TimeOfDay(
                hour: _secondPickUpEndDate.hour,
                minute: _secondPickUpEndDate.minute);

            update();
          } catch (e) {
    
          }
        }
      } else {
        showAppSnackBar(result.message ?? AppString.somethingWentWrongText.tr);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  getDateDay() {
    day = getDayOfWeek(DateTime.now().weekday);
    date = formatDayToInt(day);
    update();
  }

  Future<void> signOut(BuildContext context) async {
    // if (!emailController.text.trim().isValidEmail()) {
    //   showBottomSnackBar("Please enter valid email");
    // } else {
    hideKeyBoard(context);
    logoutLoader.value = true;

    var restID = preferences.getString(SharedPreference.REST_ID);
    var token = preferences.getString('deviceToken');
    ResponseItem result =
        ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await UserAuthRepo.userLogout(restID!, token);
    try {
      if (result.status) {
        if (result.data['result'] != null && result.data['result'] == true) {
          logoutLoader.value = false;
          preferences.logOut();
          // Get.offAllNamed(Routes.homeScreen);
          update();
        } else {
          if (token == '' || token == null) {
            preferences.logOut();
          } else {
            showAppSnackBar('unable to logout');
            logoutLoader.value = false;
          }
        }
      } else {
        showAppSnackBar(result.message!);
        logoutLoader.value = false;
      }
    } catch (e) {
      logoutLoader.value = false;
    }
    update();
    // }
  }

  @override
  void onInit() {
    getDateDay();
    getAbout();
    getTerm();
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      update();
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {}
  }
}
