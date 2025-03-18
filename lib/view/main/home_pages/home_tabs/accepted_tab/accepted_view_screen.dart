import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/printer_class.dart';
import 'package:resto_page/utils/shared_prefs.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/reverse_timer.dart';
import '../../../../../controllers/home_screen_controller.dart';
import '../status_tab_controller.dart';

class AcceptedViewScreen extends StatelessWidget {
  AcceptedViewScreen({super.key});

  final dynamic data = Get.arguments;
  final statusViewController = Get.put(StatusViewController());
  String? formattedDate;
  final dynamic preOrder = Get.arguments;
  final dynamic orderStatus = Get.arguments;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.put(HomeScreenController());
    return GetBuilder<StatusViewController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => statusViewController.getAllStatus(data["id"])),
        // Future.delayed(Duration.zero)
        //     .then((value) => statusViewController.getReservation(data["id"]))
      },
      builder: (logic) {
        final viewModel = statusViewController.viewOrderModel;
        if (viewModel?.order?.orderDate != null) {
          DateTime orderDate =
              viewModel!.order!.orderDate!; // Ensures non-null value
          formattedDate = df.format(orderDate);
          print(formattedDate); // Use the formatted date as needed
        }
        return WillPopScope(
          onWillPop: () async {
            homeScreenCtrl.getViewAll();
            homeScreenCtrl.getAccepted();
            Get.offAllNamed(Routes.homeScreen, arguments: {"selectedPage": 2});
            return true;
          },
          child: Scaffold(
              backgroundColor: viewModel?.order?.orderSpecification == "virtual"
                  ? red500Color
                  : Colors.white,
              appBar: AppAppBar(
                titleIcon: Column(children: [
                  ("#${viewModel?.order?.orderId ?? ""}")
                      .appTextStyle400(fontColor: Colors.white),
                  // (DateFormat("yyyy-mm-dd hh:mm:ss").format(viewModel?.order?.orderDate ?? DateTime.now()))
                  (formattedDate ??
                          viewModel?.order?.orderDate
                              .toString()
                              .substring(0, 19) ??
                          "")
                      .appTextStyle400(fontColor: Colors.white, fontSize: 12),
                ]),
                leadingIcon: IconButton(
                    onPressed: () {
                      homeScreenCtrl.getViewAll();
                      homeScreenCtrl.getAccepted();
                      Get.offAllNamed(Routes.homeScreen,
                          arguments: {"selectedPage": 1});
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              bottomNavigationBar: SizedBox(
                height: 190,
                child: Column(
                  children: [
                    viewModel?.order?.orderSpecification == "virtual"
                        ? testReservationCard()
                        : Container(),
                    10.0.addHSpace(),
                    AppString.customerReceiveEmailText.tr
                        .appTextStyle600(
                            fontColor: greyColor,
                            fontSize: 14,
                            textAlign: TextAlign.center)
                        .paddingSymmetric(horizontal: 15),
                    15.0.addHSpace(),
                    AppButton(
                      text: AppString.rejectButtonText.tr,
                      onTap: () {
                        Get.toNamed(Routes.rejectOrderScreen, arguments: {
                          "id": data["id"],
                          "orderDurationTime":
                              viewModel?.order?.orderDate.toString(),
                          "restId":
                              preferences.getString(SharedPreference.REST_ID),
                          "phoneNumber": viewModel?.order?.customerPhone ?? "",
                          "orderType": viewModel?.order?.orderType ?? ""
                        });
                      },
                      color: drawerColor,
                    ).paddingSymmetric(horizontal: 15),
                    20.0.addHSpace(),
                      if(Platform.isAndroid)
                    Align(
                        alignment: Alignment.centerRight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                                                         
                            AppButton(
                                text: AppString.printButtonText.tr,
                                onTap: ()async {
                                  print(viewModel);
                                  statusViewController.checkIfPosDevice(viewModel!);
                                },
                                width: 120),
                            // AppString.printerText.tr.buttonTextStyle400(
                            //     fontColor: Colors.white, fontSize: 15)
                          ],
                        )).paddingSymmetric(horizontal: 15),
                  ],
                ),
              ),
              body: formattedDate != null
                  ? Obx(() {
                      return statusViewController.isLoading.value
                          ? const AppProgress2()
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  10.0.addHSpace(),
                                  detailsCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              decoration: const BoxDecoration(
                                                  color: greenColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12))),
                                              height: 50,
                                              child: AppString.accepted2Text.tr
                                                  .appTextStyle400(
                                                      fontColor: Colors.white)
                                                  .paddingOnly(
                                                      top: 15, left: 15),
                                            )),
                                            Expanded(
                                              child: Visibility(
                                                visible: ((viewModel?.order
                                                            ?.orderRemainingTime ??
                                                        "0") !=
                                                    "0"),
                                                replacement: const SizedBox(),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    // assetImage(viewModel?.order?.orderType == "delivery" ?  AppAssets.deliveryRoundImg: AppAssets.packetRoundedImg, height: 25, width: 25),
                                                    CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            greyColor,
                                                        child: assetImage(
                                                            AppAssets
                                                                .stopwatchImg,
                                                            height: 20,
                                                            width: 20,
                                                            color:
                                                                Colors.white)),
                                                    5.0.addWSpace(),
                                                    RemainingTimer(
                                                      orderTime: viewModel
                                                                  ?.order
                                                                  ?.orderRemainingTime ==
                                                              "null"
                                                          ? "0"
                                                          : viewModel?.order
                                                                  ?.orderRemainingTime ??
                                                              "0",
                                                      fontSize: 14,
                                                      // textColor: Colors.black,
                                                    ),
                                                  ],
                                                ).paddingOnly(right: 10),
                                              ),
                                            )
                                          ],
                                        ),
                                        8.0.addHSpace(),
                                        myAccountTile(
                                            title: (viewModel
                                                    ?.order?.customerName ??
                                                "Billy Klevin"),
                                            image: AppAssets.userImg),
                                        myAccountTile(
                                            title: (viewModel
                                                    ?.order?.customerPhone ??
                                                "."),
                                            image: AppAssets.phone2Img),
                                        myAccountTile(
                                            title: (viewModel
                                                    ?.order?.customerEmail ??
                                                "."),
                                            image: AppAssets.emailImg),
                                        myAccountTile(
                                            title: (viewModel
                                                    ?.order
                                                    ?.orderPaymentMethod
                                                    ?.capitalizeFirst ??
                                                ""),
                                            image: AppAssets.coinImg),
                                        // myAccountTile(
                                        //     title: orderStatus["orderStatus"] == "delivery"
                                        //         ? "Delivery"
                                        //         : orderStatus["orderStatus"] == "pickup"
                                        //             ? "Pickup"
                                        //             : (DateFormat(
                                        //                     "dd/MM/yyyy | HH.mm").format(viewModel?.order?.orderDate ?? DateTime.now())),
                                        //     image: orderStatus["orderStatus"] ==
                                        //             "delivery"
                                        //         ? AppAssets.deliveryRoundImg
                                        //         : orderStatus["orderStatus"] ==
                                        //                 "pickup"
                                        //             ? AppAssets.packetRoundedImg
                                        //             : AppAssets.calenderImg,
                                        //     showDivider:
                                        //         orderStatus["orderStatus"] == "pickup"
                                        //             ? true
                                        //             : false),

                                        myAccountTile(
                                            title: (viewModel?.order?.orderType
                                                    ?.capitalizeFirst ??
                                                ""),
                                            image: viewModel
                                                        ?.order?.orderType ==
                                                    "delivery"
                                                ? AppAssets.deliveryRoundImg
                                                : AppAssets.packetRoundedImg,
                                            showDivider: viewModel?.order
                                                        ?.orderReservationTime ==
                                                    ""
                                                ? false
                                                : true),

                                        viewModel?.order?.orderSpecification ==
                                                "pre"
                                            ? Container()
                                            : viewModel?.order?.orderRemark ==
                                                        "" ||
                                                    viewModel?.order
                                                            ?.orderRemark ==
                                                        null
                                                ? Container()
                                                : 1.0
                                                    .appDivider(
                                                        color: const Color(
                                                            0xffe4e4e4))
                                                    .paddingSymmetric(
                                                        horizontal: 10),

                                        viewModel?.order?.orderRemark == "" ||
                                                viewModel?.order?.orderRemark ==
                                                    null
                                            ? Container()
                                            : myAccountTile(
                                                title: viewModel
                                                        ?.order?.orderRemark ??
                                                    "",
                                                image: "",
                                              ),

                                        // orderStatus["orderStatus"] == "pickup"
                                        //     ? viewModel?.order?.orderRemark == "" ? Container() :  myAccountTile(
                                        //         title: (viewModel?.order?.orderRemark ?? "."),
                                        //         image: "")
                                        //     : Container(),
                                        //
                                        //
                                        // orderStatus["orderStatus"] == "pickup"
                                        //     ? myAccountTile(
                                        //         title: ("Pre Order : ${viewModel?.order?.orderReservationTime ?? ""}"),
                                        //         image: "",
                                        //         showDivider: false)
                                        //     : Container(),

                                        viewModel?.order
                                                    ?.orderReservationTime ==
                                                ""
                                            ? Container()
                                            : myAccountTile(
                                                title:
                                                    ("Pre Order : ${viewModel?.order?.orderReservationTime ?? ""}"),
                                                image: "",
                                                showDivider: false),
                                        15.0.addHSpace(),
                                      ],
                                    ),
                                  ),
                                  10.0.addHSpace(),
                                  viewModel?.order?.orderType == "delivery"
                                      ? detailsCard(
                                          child: Column(
                                            children: [
                                              5.0.addHSpace(),
                                              myAccountTile(
                                                  title: (viewModel?.order
                                                              ?.orderType ==
                                                          "delivery"
?"${viewModel?.order?.customerFloor?.isEmpty ?? true ? "" : "${AppString.floorText.tr}: ${viewModel?.order?.customerFloor}\n"}${viewModel?.order?.customerCompanyName?.isEmpty ?? true ? "" : "${AppString.companyText.tr}: ${viewModel?.order?.customerCompanyName}\n"}${viewModel?.order?.customerAddress ?? ""} \n${viewModel?.order?.customerCity ?? ""} ${viewModel?.order?.customerPostcode ?? ""} ".replaceAll("Cancel: ", "")
                                                    : "${viewModel?.order?.customerAddress ?? ""}, ${viewModel?.order?.customerCity ?? ""}, ${viewModel?.order?.customerPostcode ?? ""} ").replaceAll("Cancel: ", ""),
                                                  image: AppAssets.locationImg,
                                                  showDivider: false),
                                              10.0.addHSpace(),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  10.0.addHSpace(),

                                  //order detail menu
                                  statusViewController.isNUllData
                                      ? Container()
                                      : detailsCard(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// ORDER DETAILS
                                              10.0.addHSpace(),

                                              itemsCard(viewModel?.items,
                                                  currency:
                                                      viewModel?.currency ?? "",
                                                  context: context),
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
                                                                      Colors
                                                                          .black,
                                                                  fontSize: 15),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              (e.value ?? "")
                                                                  .appTextStyle400(
                                                                      fontColor:
                                                                          Colors
                                                                              .black,
                                                                      fontSize:
                                                                          15),
                                                              3.0.addWSpace(),
                                                              (viewModel.currency ??
                                                                      "")
                                                                  .appTextStyle400(
                                                                      fontColor:
                                                                          Colors
                                                                              .black,
                                                                      fontSize:
                                                                          15),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  (AppString.totalTaxText.tr)
                                                      .appTextStyle400(
                                                          fontColor:
                                                              Colors.black,
                                                          fontSize: 15),
                                                  ("${viewModel?.order?.orderAmount ?? ""} ${viewModel?.currency ?? "€"}")
                                                      .appTextStyle400(
                                                          fontColor:
                                                              Colors.black,
                                                          fontSize: 15),
                                                ],
                                              ),

                                              10.0.addHSpace()
                                            ],
                                          ).paddingSymmetric(horizontal: 15),
                                        ),
                                  20.0.addHSpace()
                                ],
                              ).paddingSymmetric(horizontal: 10),
                            );
                    })
                  : Container()),
        );
      },
    );
  }
}
