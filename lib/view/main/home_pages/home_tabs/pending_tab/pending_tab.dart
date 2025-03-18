import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/models/order_model.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../controllers/home_screen_controller.dart';
import '../status_tab_controller.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.find<HomeScreenController>();
    final statusViewCtrl = Get.put(StatusViewController());
    Future<void> onRefresh() async {
      homeScreenCtrl.pendingList.clear();
      homeScreenCtrl.update();
      homeScreenCtrl.getPending();
      await Future.delayed(const Duration(seconds: 2));
    }

    return GetBuilder<HomeScreenController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => homeScreenCtrl.getPending())
      },
      builder: (logic) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          color: drawerColor,
          child: Stack(
            children: [
              ListView.builder(
                itemCount:
                    homeScreenCtrl.setOrderLength(homeScreenCtrl.pendingList),
                itemBuilder: (context, index) {
                  final pendingList = homeScreenCtrl.pendingList[index];
                  return GestureDetector(
                      onTap: () {
                        // statusViewCtrl.status =  pendingList.status == Status.PENDING ? "Pending" : "";
                        // statusViewCtrl.isTest =  pendingList.specification == Specification.VIRTUAL ? true : false;
                        // statusViewCtrl.update();
                        // Get.to(
                        //     StatusViewScreen(
                        //       id: pendingList.id,
                        // ));

                        print(homeScreenCtrl.pendingList[index].id);
                        print('order id thats outside ');
                        if (pendingList.type == OrderType.RESERVATION) {
                          // Get.toNamed(Routes.reservationScreen, arguments: {
                          //   "id": pendingList.id,
                          // });
                        } else {
                          Get.toNamed(Routes.pendingViewScreen, arguments: {
                            "id": pendingList.id,
                            "preOrder":
                                pendingList.specification == Specification.PRE
                                    ? "pre"
                                    : "Virtual"
                          });
                        }
                      },
                      child: ReservationCard(
                        orderType: pendingList.type == OrderType.DELIVERY
                            ? "delivery"
                            : pendingList.type == OrderType.PICKUP
                                ? "pickup"
                                : "reservation",
                        specification: pendingList.specification ==
                                Specification.PRE
                            ? "pre"
                            : pendingList.specification == Specification.VIRTUAL
                                ? "virtual"
                                : "real",
                        remainingAfterAccept:
                            pendingList.remainingTimeAfterAccept,
                        subTitle: pendingList.subtitle,
                        remainingTime: pendingList.remainingTime,
                        orderTime: pendingList.date,
                        isTested:
                            pendingList.specification == Specification.VIRTUAL,
                        image: pendingList.type == OrderType.RESERVATION
                            ? AppAssets.tableImg
                            : pendingList.type == OrderType.PICKUP
                                ? AppAssets.packetImg
                                : pendingList.type == OrderType.DELIVERY
                                    ? AppAssets.deliveryImg
                                    : AppAssets.packetImg,
                        status: AppString.pending2Text.tr,
                        personNumber: pendingList.title,
                      ));
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
