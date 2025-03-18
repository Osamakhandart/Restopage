import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resto_page/api/repo/change_status_repo.dart';
import 'package:resto_page/models/reservation_model.dart';
import 'package:resto_page/utils/printer_class.dart';
import 'package:resto_page/widgets/display.dart';

import '../../../../api/repo/status_repo.dart';
import '../../../../constant/app_string.dart';
import '../../../../models/home_tab_model.dart';
import '../../../../models/response_item.dart';
import '../../../../models/view_order_model.dart';
import '../../../../controllers/home_screen_controller.dart';

class StatusViewController extends GetxController {
  RxBool isLoading = false.obs;
  bool isNUllData = false;

  String id = "";
  bool isTest = false;
  String status = "";
  String selectedTime = '10';
  int duration = 10;
  ViewOrderModel? viewOrderModel;
  ReservationModel? reservationModel;
  TextEditingController timePickCtrl = TextEditingController(text: "10");
  FocusNode inputNode = FocusNode();
  DateTime currentTime = DateTime.now();
  final homeScreenCtrl = Get.put(HomeScreenController());

  List<PopUpList> popUpList = [
    PopUpList(title: AppString.min10.tr),
    PopUpList(title: AppString.min20.tr),
    PopUpList(title: AppString.min30.tr),
    PopUpList(title: AppString.min40.tr),
    PopUpList(title: AppString.min50.tr),
    PopUpList(title: AppString.min60.tr),
    PopUpList(title: AppString.min70.tr),
    PopUpList(title: AppString.min80.tr),
    PopUpList(title: AppString.min90.tr),
    PopUpList(title: AppString.otherText.tr),
  ];

  bool preOrder(DateTime orderDate) {
    bool _preOrder = false;
    DateTime _resStartTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        homeScreenCtrl.firstOpeningTime!.hour,
        homeScreenCtrl.firstOpeningTime!.hour);

    DateTime _resEndTime = DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        homeScreenCtrl.firstOpeningEndTime!.hour == 0
            ? 12
            : homeScreenCtrl.firstOpeningEndTime!.hour,
        homeScreenCtrl.firstOpeningEndTime!.minute);

    if (orderDate.isBefore(_resStartTime)) {
      _preOrder = true;
      update();
      print("Order Before Restaurant Opening");
      return _preOrder;
    } else if (orderDate.isAfter(_resEndTime)) {
      _preOrder = true;
      print("Order After Restaurant Closing");
      update();
      return _preOrder;
    } else {
      print("Order When Restaurant Opened");
      _preOrder = false;
      update();
      return _preOrder;
    }
  }

  onChangeTimer(value) {
    selectedTime = value;
    duration = int.parse(selectedTime.replaceAll(RegExp(r'[^0-9]'), ''));
    // duration = int.parse(selectedTime.replaceAll(RegExp(r'[^0-9]'), '') )* 60;
    timePickCtrl.text = value.replaceAll(RegExp(r'[^0-9]'), '');
    print("Duration ----> $duration");
    update();
  }

  onChangeTextField(value) {
    if (value != null) {
      selectedTime = value;
      duration = int.parse(selectedTime.replaceAll(RegExp(r'[^0-9]'), ''));
      print("Duration ----> $duration");
      update();
    } else {
      duration = 60;
      update();
    }
  }
  void checkIfPosDevice( ViewOrderModel?  viewModel, {String? prepareDuration}) async {



    if (Platform.isAndroid) {
      var deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;


      // Here you check the specific property, for example, the model or brand
      if (androidInfo.model.contains('GT90EZ') ||androidInfo.model.contains('GT90ez') || androidInfo.model.contains('NB55')) {
        var printService = PrintService(viewModel!);
// printService.printOrderReceipt();
         printService.printOrderReceipt(duration: prepareDuration);
      }
    }
  }
  getAllStatus(String id) async {
    isLoading.value = true;
    ResponseItem result;
    ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await StatusRepo.getOrderStatus(id);
    try {
      if (result.status) {
        if (result.data != null) {
          print(result.data);
          try {
            ViewOrderModel viewOrderMod =
                viewOrderModelFromJson(jsonEncode(result.data));
            viewOrderModel = viewOrderMod;

            print("order id inside the tab ${viewOrderModel?.order?.orderId}");
            print(
                "order id inside the tab ${viewOrderModel?.order?.orderRemainingTime}");
            isLoading.value = false;
            update();
          } catch (e) {
            print("Error is ---> $e");
          }
        }
      } else {
        isLoading.value = false;
        isNUllData = true;
        // showAppSnackBar(result.message!);

        update();
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  getReservation(String id) async {
    isLoading.value = true;
    ResponseItem result;
    ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await StatusRepo.getReservation(id);
    try {
      if (result.status) {
        if (result.data != null) {
          try {
            ReservationModel reservModel =
                reservationModelFromJson(jsonEncode(result.data));
            reservationModel = reservModel;
            isLoading.value = false;
            update();
          } catch (e) {
            print("Error is ---> $e");
          }
        }
      } else {
        isLoading.value = false;
        isNUllData = true;
        update();
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  acceptOrder(
      {required String orderId,
      required String restId,
      required String orderDurationTime,
      required String orderType}) async {
    isLoading.value = true;
    await ChangeStatusRepo.acceptOrderStatus(
        orderId: orderId,
        restId: restId,
        orderDurationTime: orderDurationTime,
        orderType: orderType);

    isLoading.value = false;
    update();
  }

  Future cancelOrder({
    required String orderId,
    required String restId,
    required String orderDurationTime,
    required String id,
  }) async {
    isLoading.value = true;
    await ChangeStatusRepo.cancelOrderStatus(
        orderId: orderId, restId: restId, orderDurationTime: orderDurationTime);
    print("viewOrderModel000 ---> ${viewOrderModel?.order?.orderId}");

    isLoading.value = false;
    update();
  }
}
