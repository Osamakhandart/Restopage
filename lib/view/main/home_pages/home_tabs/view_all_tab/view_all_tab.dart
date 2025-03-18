import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/models/order_model.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../../../constant/app_color.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../controllers/home_screen_controller.dart';

class ViewAllTab extends StatelessWidget {
  const ViewAllTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.find<HomeScreenController>();

    Future<void> onRefresh() async {
      homeScreenCtrl.viewAllList.clear();
      homeScreenCtrl.update();
      homeScreenCtrl.getViewAll();
      await Future.delayed(const Duration(seconds: 2));
    }

    return GetBuilder<HomeScreenController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => homeScreenCtrl.getViewAll())
      },
      builder: (logic) {
        return RefreshIndicator(
          color: drawerColor,
          onRefresh: onRefresh,
          child:
              // Obx(
              //   () => homeScreenCtrl.isLoading.value
              //       ? const AppProgress()
              //       :
              Stack(
            children: [
              ListView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                // shrinkWrap: true,
                itemCount:
                    homeScreenCtrl.setOrderLength(homeScreenCtrl.viewAllList),
                //homeScreenCtrl.viewAllList.length,
                itemBuilder: (context, index) {
                  final viewAllList = homeScreenCtrl.viewAllList[index];

                  return GestureDetector(
                    onTap: () {
                      // homeScreenCtrl.sliderDrawerKey.currentState?.closeSlider();

                     
                      if (viewAllList.type == OrderType.RESERVATION) {
                        if (viewAllList.status == Status.PENDING) {
                          Get.toNamed(Routes.reservationScreen, arguments: {
                            "id": viewAllList.id,
                            "isTested": viewAllList.specification ==
                                    Specification.VIRTUAL
                                ? true
                                : false,
                          });
                        } else if (viewAllList.status == Status.ACCEPTED) {
                          Get.toNamed(Routes.accptedReservationScreen,
                              arguments: {
                                "id": viewAllList.id,
                                "isTested": viewAllList.specification ==
                                        Specification.VIRTUAL
                                    ? true
                                    : false,
                              });
                        } else if (viewAllList.status == Status.CANCELED) {
                          Get.toNamed(Routes.rejectedReservationScreen,
                              arguments: {
                                "id": viewAllList.id,
                                "isTested": viewAllList.specification ==
                                        Specification.VIRTUAL
                                    ? true
                                    : false,
                              });
                        }
                      } else {
                        if (viewAllList.status == Status.PENDING) {
                          Get.toNamed(Routes.pendingViewScreen, arguments: {
                            "id": viewAllList.id,
                            "isTested": viewAllList.specification ==
                                    Specification.VIRTUAL
                                ? true
                                : false,
                            "preOrder":
                                viewAllList.specification == Specification.PRE
                                    ? "pre"
                                    : "Virtual"
                          });
                        } else if (viewAllList.status == Status.ACCEPTED) {
                          Get.toNamed(Routes.acceptedViewScreen, arguments: {
                            "id": viewAllList.id,
                            "isTested": viewAllList.specification ==
                                    Specification.VIRTUAL
                                ? true
                                : false,
                            "preOrder":
                                viewAllList.specification == Specification.PRE
                                    ? "pre"
                                    : "Virtual",
                            "orderStatus": viewAllList.type == OrderType.PICKUP
                                ? "pickup"
                                : viewAllList.type == OrderType.DELIVERY
                                    ? "delivery"
                                    : "reservation"
                          });
                        } else if (viewAllList.status == Status.CANCELED) {
                          Get.toNamed(Routes.rejectedViewScreen, arguments: {
                            "id": viewAllList.id,
                            "isTested": viewAllList.specification ==
                                    Specification.VIRTUAL
                                ? true
                                : false,
                            "preOrder":
                                viewAllList.specification == Specification.PRE
                                    ? "pre"
                                    : "Virtual"
                          });
                        } else {
                          null;
                        }
                      }
                    },
                    child: ReservationCard(
                      orderType: viewAllList.type == OrderType.DELIVERY
                          ? "delivery"
                          : viewAllList.type == OrderType.PICKUP
                              ? "pickup"
                              : "reservation",
                      specification: viewAllList.specification ==
                              Specification.PRE
                          ? "pre"
                          : viewAllList.specification == Specification.VIRTUAL
                              ? "virtual"
                              : "real",
                      remainingAfterAccept:
                          viewAllList.remainingTimeAfterAccept,
                      subTitle: viewAllList.subtitle,
                      remainingTime: viewAllList.remainingTime,
                      isTested:
                          viewAllList.specification == Specification.VIRTUAL
                              ? true
                              : false,
                      image: viewAllList.type == OrderType.RESERVATION
                          ? AppAssets.tableImg
                          : viewAllList.type == OrderType.PICKUP
                              ? AppAssets.packetImg
                              : viewAllList.type == OrderType.DELIVERY
                                  ? AppAssets.deliveryImg
                                  : AppAssets.packetImg,
                      status: viewAllList.status == Status.CANCELED
                          ? AppString.rejected2Text.tr
                          : viewAllList.status == Status.PENDING
                              ? AppString.pending2Text.tr
                              : AppString.accepted2Text.tr,
                      personNumber: viewAllList.title,
                      orderTime: viewAllList.date,
                      // remainingTimeAfterAccept : viewAllList.remainingTimeAfterAccept
                    ),
                  );
                },
              ),
              Obx(() => homeScreenCtrl.isLoading.value
                  ? const AppProgress()
                  : Container())
              // Obx(() => homeScreenCtrl.isLoading.value
              //     ? const AppProgress()
              //     : Container())
            ],
          ),
        );
      },
    );
  }
}
