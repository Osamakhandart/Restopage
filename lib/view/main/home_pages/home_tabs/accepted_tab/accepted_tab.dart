import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/models/order_model.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_progress.dart';
import '../../../../../controllers/home_screen_controller.dart';

class AcceptedTab extends StatelessWidget {
  const AcceptedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.find<HomeScreenController>();

    Future<void> onRefresh() async {
      homeScreenCtrl.acceptedList.clear();

      homeScreenCtrl.update();
      homeScreenCtrl.getAccepted();
      await Future.delayed(const Duration(seconds: 2));
    }

    return GetBuilder<HomeScreenController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => homeScreenCtrl.getAccepted())
      },
      builder: (logic) {
        return RefreshIndicator(
          color: drawerColor,
          onRefresh: onRefresh,
          child: Stack(
            children: [
              ListView.builder(
                itemCount:
                    homeScreenCtrl.setOrderLength(homeScreenCtrl.acceptedList),
                itemBuilder: (context, index) {
                  final acceptedList = homeScreenCtrl.acceptedList[index];
                  return GestureDetector(
                    onTap: () {
                      // homeScreenCtrl.convertDateTimeFormat(subtitle);
                      Get.toNamed(Routes.acceptedViewScreen, arguments: {
                        "id": acceptedList.id,
                        "isTested":
                            acceptedList.specification == Specification.VIRTUAL
                                ? true
                                : false,
                        "preOrder":
                            acceptedList.specification == Specification.PRE
                                ? "pre"
                                : "Virtual",
                        "orderStatus": acceptedList.type == OrderType.PICKUP
                            ? "pickup"
                            : acceptedList.type == OrderType.DELIVERY
                                ? "delivery"
                                : "reservation"
                      });
                    },
                    child: ReservationCard(
                      orderType: acceptedList.type == OrderType.DELIVERY
                          ? "delivery"
                          : acceptedList.type == OrderType.PICKUP
                              ? "pickup"
                              : "reservation",
                      specification: acceptedList.specification ==
                              Specification.PRE
                          ? "pre"
                          : acceptedList.specification == Specification.VIRTUAL
                              ? "virtual"
                              : "real",
                      remainingAfterAccept:
                          acceptedList.remainingTimeAfterAccept,
                      subTitle: acceptedList.subtitle,
                      remainingTime: acceptedList.remainingTime,
                      isTested:
                          acceptedList.specification == Specification.VIRTUAL
                              ? true
                              : false,
                      image: acceptedList.type == OrderType.RESERVATION
                          ? AppAssets.tableImg
                          : acceptedList.type == OrderType.PICKUP
                              ? AppAssets.packetImg
                              : acceptedList.type == OrderType.DELIVERY
                                  ? AppAssets.deliveryImg
                                  : AppAssets.packetImg,
                      status: AppString.accepted2Text.tr,
                      personNumber: acceptedList.title,
                      orderTime: acceptedList.date,
                      // remainingTimeAfterAccept: acceptedList.remainingTimeAfterAccept,
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
