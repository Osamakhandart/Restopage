import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_app_bar.dart';
import 'package:resto_page/widgets/app_button.dart';

import '../../../../constant/app_string.dart';
import '../../../../utils/app_routes.dart';
import '../../../../widgets/app_progress.dart';
import '../../../../controllers/home_screen_controller.dart';
import '../../../../controllers/new_test_order_controller.dart';

class NewTestOrderScreen extends StatelessWidget {
  NewTestOrderScreen({super.key});

  final testOrderController = Get.put(NewTestOrderController());
  final homeScreenCtrl = Get.find<HomeScreenController>();




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async {
        getOrderReservation();
        Get.back();
        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            appBar: AppAppBar(
              titleText: AppString.newTestOrderText.tr,
              leadingIcon: IconButton(
                  onPressed: () {
                    getOrderReservation();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            body: Column(
              children: [
                10.0.addHSpace(),
                AppButton(
                    text: AppString.testNewDeliveryOrderText.tr,
                    onTap: () {
                      testOrderController.deliveryOrder();
                    }),
                10.0.addHSpace(),
                AppButton(
                    text: AppString.testNewPickUpOrderText.tr,
                    onTap: () {
                      testOrderController.pickUpOrder();
                    }),
                10.0.addHSpace(),
                AppButton(
                    text: AppString.testNewReservationText.tr,
                    onTap: () {
                      testOrderController.reservationOrder();
                    }),
                10.0.addHSpace(),

              ],
            ).paddingSymmetric(horizontal: 20),
          ),
          Obx(() => testOrderController.isLoading.value
              ? const AppProgress()
              : Container())
        ],
      ),
    );
  }

  getOrderReservation() {
    homeScreenCtrl.viewAllList .clear();
    homeScreenCtrl.pendingList .clear();
    homeScreenCtrl.acceptedList.clear();
    homeScreenCtrl.rejectedList.clear();
    homeScreenCtrl.update();
    homeScreenCtrl.getViewAll();
    homeScreenCtrl.getPending();
    homeScreenCtrl.getAccepted();
    homeScreenCtrl.getRejected();
  }


}
