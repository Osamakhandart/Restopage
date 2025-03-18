import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/shared_prefs.dart';
import 'package:resto_page/widgets/app_button.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_progress.dart';
import '../../../../../widgets/reverse_timer.dart';
import '../../../../../controllers/home_screen_controller.dart';
import '../accepted_tab/pick_up_time_screen.dart';
import '../status_tab_controller.dart';

class PendingViewScreen extends StatelessWidget {
  PendingViewScreen({super.key, this.id});

  final statusViewController = Get.put(StatusViewController());
  final dynamic data = Get.arguments;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final statusViewController = Get.put(StatusViewController());
    final homeScreenCtrl = Get.find<HomeScreenController>();
    return GetBuilder<StatusViewController>(
      initState: (initState) => {
        Future.delayed(Duration.zero).then(
            (value) => statusViewController.getAllStatus(id ?? data["id"])),
      },
      builder: (logic) {
        final viewModel = statusViewController.viewOrderModel;

        // final reservationModel = statusViewController.reservationModel;
        return WillPopScope(
          onWillPop: () async {
            homeScreenCtrl.getViewAll();
            homeScreenCtrl.getPending();
            Get.offAllNamed(Routes.homeScreen);
            return true;
          },
          child: Scaffold(
              backgroundColor: viewModel?.order?.orderSpecification == "virtual"
                  ? red500Color
                  : Colors.white,
              appBar: AppAppBar(
                titleIcon: Column(children: [
                  ("#${viewModel?.order?.orderId ?? "71"}")
                      .appTextStyle400(fontColor: Colors.white),
                  // (DateFormat("yyyy-mm-dd hh:mm:ss").format(viewModel?.order?.orderDate ?? DateTime.now()))
                  (viewModel?.order?.orderDate.toString().substring(0, 19) ??
                          "")
                      .appTextStyle400(fontColor: Colors.white, fontSize: 12),
                ]),
                leadingIcon: IconButton(
                    onPressed: () {
                      homeScreenCtrl.getViewAll();
                      homeScreenCtrl.getPending();
                      Get.offAllNamed(Routes.homeScreen);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              bottomNavigationBar: Container(
                height: 160,
                color: viewModel?.order?.orderSpecification != "virtual"
                    ? Colors.white
                    : red500Color,
                child: Column(
                  children: [
                    viewModel?.order?.orderSpecification != "virtual"
                        ? Container()
                        : testReservationCard(),
                    Column(
                      children: [
                        15.0.addHSpace(),
                        Padding(padding: EdgeInsets.only(left: 10,right: 10),child:  AppString.youHave20MinutesText.tr.appTextStyle400(
                            fontColor: greyColor, textAlign: TextAlign.center),),
                       
                        15.0.addHSpace(),
                        Row(
                          children: [
                            Expanded(
                                child: AppButton(
                              text: AppString.acceptButtonText.tr,
                              onTap: () {
                                if (statusViewController.isLoading.value) {
                                  null;
                                } else {
                           
                                  Get.to(PickUpTimeScreen(
                                    id: data["id"] ?? "",
                                    orderTime: viewModel?.order?.orderDate ??
                                        DateTime.now(),
                                    orderSpecification:
                                        viewModel?.order?.orderSpecification ??
                                            "",
                                    orderType: viewModel?.order?.orderType,viewModel: viewModel,
                                  ));
                                }
                              },
                              color: greenColor,
                            )),
                            5.0.addWSpace(),
                            Expanded(
                                child: AppButton(
                              text: AppString.rejectButtonText.tr,
                              onTap: () {
                                Get.toNamed(Routes.rejectOrderScreen,
                                    arguments: {
                                      "id": data["id"],
                                      "orderId": statusViewController!
                                          .viewOrderModel!.order!.orderId!,
                                      "orderDurationTime": statusViewController!
                                          .viewOrderModel!
                                          .order!
                                          .orderDurationTime!,
                                      "restId": preferences
                                          .getString(SharedPreference.REST_ID)!,
                                      "orderType":
                                          viewModel?.order?.orderType ?? ""
                                      // "phoneNumber" : reservationModel?.telephone
                                    });
                              },
                              color: drawerColor,
                            )),
                          ],
                        ).paddingSymmetric(horizontal: 20)
                      ],
                    )
                  ],
                ),
              ),
              body: Obx(() {
                return statusViewController.isLoading.value
                    ? const AppProgress2()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            10.0.addHSpace(),
                            detailsCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: const BoxDecoration(
                                            color: red800Color,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12))),
                                        height: 50,
                                        child: AppString.pending2Text.tr
                                            .appTextStyle400(
                                                fontColor: Colors.white)
                                            .paddingOnly(top: 15, left: 15),
                                      )),
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          viewModel?.order?.orderRemainingTime ==
                                                      null ||
                                                  viewModel?.order
                                                          ?.orderRemainingTime ==
                                                      "" ||
                                                  viewModel?.order
                                                          ?.orderRemainingTime ==
                                                      "remaining_time" ||
                                                  viewModel?.order
                                                          ?.orderRemainingTime ==
                                                      "00"
                                              ? Container()
                                              : viewModel?.order?.orderStatus ==
                                                      "pending"
                                                  ? Row(
                                                      children: [
                                                        CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor:
                                                                greyColor,
                                                            child: assetImage(
                                                                AppAssets
                                                                    .stopwatchImg,
                                                                height: 20,
                                                                width: 20,
                                                                color: Colors
                                                                    .white)),
                                                        5.0.addWSpace(),
                                                        DeliveryTimer(
                                                            dateTime: viewModel
                                                                    ?.order
                                                                    ?.orderRemainingTime ??
                                                                "00",
                                                            textColor:
                                                                greyColor),
                                                      ],
                                                    ).paddingOnly(right: 10)
                                                  : Container()
                                        ],
                                      ))
                                    ],
                                  ),
                                  8.0.addHSpace(),
                                  myAccountTile(
                                      title: (viewModel?.order?.customerName ??
                                          "."),
                                      image: AppAssets.userImg),
                                  myAccountTile(
                                      title: (viewModel?.order?.customerPhone ??
                                          "."),
                                      image: AppAssets.phone2Img),
                                  myAccountTile(
                                      title: (viewModel?.order?.customerEmail ??
                                          "."),
                                      image: AppAssets.emailImg),
                                  myAccountTile(
                                      title: (viewModel
                                              ?.order?.orderPaymentMethod ??
                                          "."),
                                      image: AppAssets.coinImg),

                                  myAccountTile(
                                      title: viewModel?.order?.orderType
                                              ?.capitalizeFirst ??
                                          "",
                                      image: AppAssets.deliveryRoundImg,
                                      showDivider: viewModel
                                                  ?.order?.orderSpecification ==
                                              "pre"
                                          ? true
                                          : false),
                                  // showDivider: statusViewController.isNUllData ? false : true),

                                  viewModel?.order?.orderSpecification == "pre"
                                      ? Container()
                                      : viewModel?.order?.orderRemark == "" ||
                                              viewModel?.order?.orderRemark ==
                                                  null
                                          ? Container()
                                          : 1.0
                                              .appDivider(
                                                  color:
                                                      const Color(0xffe4e4e4))
                                              .paddingSymmetric(horizontal: 10),

                                  viewModel?.order?.orderRemark == "" ||
                                          viewModel?.order?.orderRemark == null
                                      ? Container()
                                      : myAccountTile(
                                          title:
                                              viewModel?.order?.orderRemark ??
                                                  "",
                                          image: "",
                                        ),

                                  statusViewController.isNUllData
                                      ? Container()
                                      : viewModel?.order?.orderSpecification ==
                                              "pre"
                                          ? myAccountTile(
                                              title:
                                                  "Pre Order : ${(viewModel?.order?.orderReservationTime ?? ".")}",
                                              image: "",
                                              showDivider: false)
                                          : Container(),

                                  15.0.addHSpace(),
                                ],
                              ),
                            ),
                            10.0.addHSpace(),
                            statusViewController.isNUllData
                                ? Container()
                                : viewModel?.order?.orderType == "pickup"
                                    ? Container()
                                    : detailsCard(
                                        child: Column(
                                          children: [
                                            5.0.addHSpace(),
                                            myAccountTile(
                                                title: (viewModel?.order
                                                            ?.orderType ==
                                                        "delivery"
?"${viewModel?.order?.customerFloor?.isEmpty ?? true ? "" : "${AppString.floorText.tr}: ${viewModel?.order?.customerFloor}\n"}${viewModel?.order?.customerCompanyName?.isEmpty ?? true ? "" : "${AppString.companyText.tr}: ${viewModel?.order?.customerCompanyName}\n"}${viewModel?.order?.customerAddress ?? ""} \n${viewModel?.order?.customerCity ?? ""}, ${viewModel?.order?.customerPostcode ?? ""} ".replaceAll("Cancel: ", "")
                                                    : "${viewModel?.order?.customerAddress ?? ""}, ${viewModel?.order?.customerCity ?? ""}, ${viewModel?.order?.customerPostcode ?? ""} ").replaceAll("Cancel: ", ""),
                                                image: AppAssets.locationImg,
                                                showDivider: false),
                                            10.0.addHSpace(),
                                          ],
                                        ),
                                      ),
                            10.0.addHSpace(),
                            statusViewController.isNUllData
                                ? Container()
                                : detailsCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// ORDER DETAILS
                                        10.0.addHSpace(),

                                        itemsCard(
                                          context: context,
                                          viewModel?.items,
                                          currency: viewModel?.currency ?? "",
                                        ),
                                        10.0.addHSpace(),

                                        /// SUB TOTAL
                                        0.3.appDivider(color: greyColor),
                                        10.0.addHSpace(),

                                        ...?viewModel?.subTotal
                                            ?.map((e) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    (e.label ?? "")
                                                        .appTextStyle400(
                                                            fontColor:
                                                                Colors.black,
                                                            fontSize: 15),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        (e.value ?? "")
                                                            .appTextStyle400(
                                                                fontColor:
                                                                    Colors
                                                                        .black,
                                                                fontSize: 15),
                                                        3.0.addWSpace(),
                                                        (viewModel.currency ??
                                                                "")
                                                            .appTextStyle400(
                                                                fontColor:
                                                                    Colors
                                                                        .black,
                                                                fontSize: 15),
                                                      ],
                                                    )
                                                  ],
                                                ))
                                            .toList(),

                                        10.0.addHSpace(),
                                        0.3.appDivider(color: greyColor),
                                        10.0.addHSpace(),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            (AppString.totalTaxText.tr)
                                                .appTextStyle400(
                                                    fontColor: Colors.black,
                                                    fontSize: 15),
                                            ("${viewModel?.order?.orderAmount} ${viewModel?.currency}")
                                                .appTextStyle400(
                                                    fontColor: Colors.black,
                                                    fontSize: 15),
                                          ],
                                        ),

                                        10.0.addHSpace()
                                      ],
                                    ).paddingSymmetric(horizontal: 15),
                                  ),
                            20.0.addHSpace(),
                          ],
                        ).paddingSymmetric(horizontal: 10),
                      );
              })),
        );
      },
    );
  }

  DateTime currentTime = DateTime.now();
}
