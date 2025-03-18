import 'package:get/get.dart';
import 'package:resto_page/controllers/home_screen_controller.dart';

import 'package:resto_page/api/repo/create_test_order_repo.dart';
import 'package:resto_page/models/response_item.dart';
import 'package:resto_page/theme/app_layout.dart';

class NewTestOrderController extends GetxController {
  RxBool isLoading = false.obs;
  final homeScreenCtrl = Get.find<HomeScreenController>();

  deliveryOrder() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await CreateTestOrderRepo.deliveryOrder();
    try {
      if (result.status) {
        if (result.data != null) {
          // List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          // viewAllList = order;
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

  pickUpOrder() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await CreateTestOrderRepo.pickupOrder();
    try {
      if (result.status) {
        if (result.data != null) {
          // List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          // viewAllList = order;
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

  reservationOrder() async {
    isLoading.value = true;
    ResponseItem result;
    // ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await CreateTestOrderRepo.reservationOrder();
    try {
      if (result.status) {
        if (result.data != null) {
          // List<OrderModel> order = orderModelFromJson(jsonEncode(result.data));
          // viewAllList = order;
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



}
