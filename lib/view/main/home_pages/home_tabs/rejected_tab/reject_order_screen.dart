import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/shared_prefs.dart';
import 'package:resto_page/widgets/app_button.dart';
import 'package:resto_page/widgets/app_progress.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../controllers/status_tab_controller.dart';

class RejectOrderScreen extends StatelessWidget {
  RejectOrderScreen({super.key});

  final id = Get.arguments;
  final orderId = Get.arguments;
  final orderDurationTime = Get.arguments;
  final restId = Get.arguments;
  final phoneNumber = Get.arguments;
  final orderType = Get.arguments;

  final statusViewController = Get.put(StatusViewController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppAppBar(
            leadingIcon: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                )),
            titleText: AppString.rejectOrderTitleText.tr,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              15.0.addHSpace(),
              AppString.rejectOrder1Text.tr
                  .appTextStyle400(fontColor: greyFontColor, fontSize: 16),
              10.0.addHSpace(),
              AppButton(
                text: AppString.callCustomerText.tr,
                onTap: () async {
                  // String telephoneNumber = '1234';
                  String telephoneUrl = "tel:${phoneNumber["phoneNumber"]}";
                  if (await canLaunch(telephoneUrl)) {
                    await launch(telephoneUrl);
                  } else {
                    throw "Error occured trying to call that number.";
                  }
                },
                color: greenColor,
              ),
              10.0.addHSpace(),
              AppString.rejectOrder2Text.tr
                  .appTextStyle400(fontColor: greyFontColor, fontSize: 16),
              10.0.addHSpace(),
              AppButton(
                text: orderType["orderType"] == "reservation" ? "Reject Table Reservation" : AppString.rejectTableConservationText.tr,
                onTap: () async {
                 try{
                   await statusViewController.cancelOrder(
                     orderId: id["id"] ?? statusViewController.viewOrderModel!.order!.orderId!,
                     id: id["id"] ?? statusViewController.viewOrderModel!.order!.orderId!,
                     orderDurationTime: orderDurationTime["orderDurationTime"],
                     restId: preferences.getString(SharedPreference.REST_ID)!,

                   );

                    if(orderType["orderType"] == "reservation"){
                     Get.offAllNamed(Routes.rejectedReservationScreen, arguments: {
                       "id": id["id"],
                       "isTested": false,
                     });
                   }else {
                     Get.offAllNamed(Routes.rejectedViewScreen, arguments: {
                       "id": id["id"],
                       "isTested": false,
                       "preOrder": "Virtual",
                       "orderStatus": "reservation"
                     });
                   }

                 }catch(e){}
                },
                color: drawerColor,
              ),
              10.0.addHSpace(),
              AppString.rejectTableSubText.tr
                  .appTextStyle400(fontColor: greyFontColor, fontSize: 16),
            ],
          ).paddingSymmetric(horizontal: 25),
        ),
        Obx(() => statusViewController.isLoading.value
            ? const AppProgress()
            : Container())
      ],
    );
  }
}
