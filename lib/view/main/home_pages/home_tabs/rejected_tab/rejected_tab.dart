import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/models/order_model.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_progress.dart';
import '../../../../../controllers/home_screen_controller.dart';

class RejectedTab extends StatelessWidget {
  const RejectedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.find<HomeScreenController>();
    Future<void> onRefresh() async {
      homeScreenCtrl.rejectedList.clear();
      homeScreenCtrl.update();
      homeScreenCtrl.getRejected();

      await Future.delayed(const Duration(seconds: 2));
    }

    return GetBuilder<HomeScreenController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => homeScreenCtrl.getRejected())
      },
      builder: (logic) {
        return RefreshIndicator(
          color: drawerColor,
          onRefresh: onRefresh,
          child: Stack(
            children: [
              ListView.builder(
                itemCount:
                    homeScreenCtrl.setOrderLength(homeScreenCtrl.rejectedList),
                itemBuilder: (context, index) {
                  final rejectedList = homeScreenCtrl.rejectedList[index];
                  return GestureDetector(
                    onTap: () {
                      if (rejectedList.type == OrderType.RESERVATION) {
                        Get.toNamed(Routes.rejectedReservationScreen,
                            arguments: {
                              "id": rejectedList.id,
                              "isTested": rejectedList.specification ==
                                      Specification.VIRTUAL
                                  ? true
                                  : false,
                            });
                      } else {
                        Get.toNamed(Routes.rejectedViewScreen, arguments: {
                          "id": rejectedList.id,
                          "isTested": rejectedList.specification ==
                                  Specification.VIRTUAL
                              ? true
                              : false,
                          "orderStatus": rejectedList.type == OrderType.PICKUP
                              ? "pickup"
                              : rejectedList.type == OrderType.DELIVERY
                                  ? "delivery"
                                  : "reservation"
                        });
                      }
                    },
                    child: ReservationCard(
                      orderType: rejectedList.type == OrderType.DELIVERY
                          ? "delivery"
                          : rejectedList.type == OrderType.PICKUP
                              ? "pickup"
                              : "reservation",
                      specification: rejectedList.specification ==
                              Specification.PRE
                          ? "pre"
                          : rejectedList.specification == Specification.VIRTUAL
                              ? "virtual"
                              : "real",
                      remainingAfterAccept:
                          rejectedList.remainingTimeAfterAccept,
                      subTitle: rejectedList.subtitle,
                      remainingTime: rejectedList.remainingTime,
                      isTested:
                          rejectedList.specification == Specification.VIRTUAL
                              ? true
                              : false,
                      image: rejectedList.type == OrderType.RESERVATION
                          ? AppAssets.tableImg
                          : rejectedList.type == OrderType.PICKUP
                              ? AppAssets.packetImg
                              : rejectedList.type == OrderType.DELIVERY
                                  ? AppAssets.deliveryImg
                                  : AppAssets.packetImg,
                      status: AppString.rejected2Text.tr,
                      personNumber: rejectedList.title,
                    ),
                  );
                },
              ),
              Obx(() => homeScreenCtrl.isLoading.value
                  ? const AppProgress()
                  : Container())
            ],
          ),
        );
      },
    );
  }
}
// List<ViewAllModel> rejectedList = [
//   ViewAllModel(
//       image: AppAssets.tableImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Credit Card",
//       person: "6 Ridgewood Center Dr Old Forge"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Paypal",
//       person: "2"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Debit Card",
//       person: "6 Ridgewood Center Dr Old Forge"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Cash",
//       person: "1"),
//   ViewAllModel(
//       image: AppAssets.packetImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Paypal",
//       person: "6 Ridgewood Center Dr Old Forge"),
//   ViewAllModel(
//       image: AppAssets.tableImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Debit Card",
//       person: "10"),
//   ViewAllModel(
//       image: AppAssets.tableImg,
//       status: AppString.rejected2Text.tr,
//       isTest: false,
//       payment: "Credit Card",
//       person: "6 Ridgewood Center Dr Old Forge"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: false,
//       payment: "Debit Card",
//       person: "20"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: false,
//       payment: "Cash",
//       person: "6 Ridgewood Center Dr Old Forge"),
//   ViewAllModel(
//       image: AppAssets.deliveryImg,
//       status: AppString.rejected2Text.tr,
//       isTest: false,
//       payment: "Cash",
//       person: "6 Jones"),
//   ViewAllModel(
//       image: AppAssets.packetImg,
//       status: AppString.rejected2Text.tr,
//       isTest: true,
//       payment: "Paypal",
//       person: "1 Show"),
//   ViewAllModel(
//       image: AppAssets.tableImg,
//       status: AppString.rejected2Text.tr,
//       isTest: false,
//       payment: "Paypal",
//       person: "6 Ridgewood Center Dr Old Forge"),
// ];
