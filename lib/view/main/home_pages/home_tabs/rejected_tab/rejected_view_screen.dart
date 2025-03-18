import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_app_bar.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../controllers/home_screen_controller.dart';
import '../status_tab_controller.dart';

class RejectedViewScreen extends StatelessWidget {
  RejectedViewScreen({super.key});
  String? formattedDate;
  final statusViewController = Get.put(StatusViewController());
  final dynamic data = Get.arguments;
  final dynamic preOrder = Get.arguments;
  final dynamic orderStatus = Get.arguments;
  final df = new DateFormat('dd-MM-yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.put(HomeScreenController());

    return GetBuilder<StatusViewController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => statusViewController.getAllStatus(data["id"]))
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
            homeScreenCtrl.getRejected();
            Get.offAllNamed(Routes.homeScreen, arguments: {"selectedPage": 1});
            return true;
          },
          child: Scaffold(
              backgroundColor: viewModel?.order?.orderSpecification == "virtual"
                  ? red100Color
                  : Colors.white,
              bottomNavigationBar: SizedBox(
                height: 20,
                child: viewModel?.order?.orderSpecification == "virtual"
                    ? testReservationCard()
                    : Container(),
              ).paddingOnly(
                  bottom: viewModel?.order?.orderSpecification == "virtual"
                      ? 20
                      : 0),
              appBar: AppAppBar(
                titleIcon: Column(children: [
                  ("#${viewModel?.order?.orderId ?? ""}")
                      .appTextStyle400(fontColor: Colors.white),
                  // (DateFormat("yyyy-mm-dd hh:mm:ss a").format(viewModel?.order?.orderDate ?? DateTime.now()))
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
                      homeScreenCtrl.getRejected();
                      Get.offAllNamed(Routes.homeScreen,
                          arguments: {"selectedPage": 1});
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              body: Obx(() => statusViewController.isLoading.value
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
                                          color: drawerColor,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12))),
                                      height: 50,
                                      child: AppString.rejected2Text.tr
                                          .appTextStyle400(
                                              fontColor: Colors.white)
                                          .paddingOnly(top: 15, left: 15),
                                    )),
                                    Expanded(
                                      child: Container(),
                                    )
                                  ],
                                ),
                                8.0.addHSpace(),
                                myAccountTile(
                                    title:
                                        (viewModel?.order?.customerName ?? "."),
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
                                    title:
                                        (viewModel?.order?.orderPaymentMethod ??
                                            "."),
                                    image: AppAssets.coinImg),
                                myAccountTile(
                                    title: (viewModel?.order?.orderType
                                            ?.capitalizeFirst ??
                                        "."),
                                    image: viewModel?.order?.orderType ==
                                            "delivery"
                                        ? AppAssets.deliveryRoundImg
                                        : AppAssets.packetRoundedImg,
                                    showDivider:
                                        viewModel?.order?.orderSpecification ==
                                                "pre"
                                            ? true
                                            : false),
                                viewModel?.order?.orderSpecification == "pre"
                                    ? Container()
                                    : viewModel?.order?.orderRemark == "" ||
                                            viewModel?.order?.orderRemark ==
                                                null
                                        ? Container()
                                        : 1.0
                                            .appDivider(
                                                color: const Color(0xffe4e4e4))
                                            .paddingSymmetric(horizontal: 10),
                                viewModel?.order?.orderRemark == "" ||
                                        viewModel?.order?.orderRemark == null
                                    ? Container()
                                    : myAccountTile(
                                        title:
                                            viewModel?.order?.orderRemark ?? "",
                                        image: "",
                                      ),
                                viewModel?.order?.orderSpecification == "pre"
                                    ? myAccountTile(
                                        title:
                                            "Pre Order : ${(viewModel?.order?.orderReservationTime ?? ".")}",
                                        image: "",
                                        showDivider: false)
                                    : Container(),
                                10.0.addHSpace()
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
                                              title: (viewModel
                                                          ?.order?.orderType ==
                                                      "delivery"
?"${viewModel?.order?.customerFloor?.isEmpty ?? true ? "" : "${AppString.floorText.tr}: ${viewModel?.order?.customerFloor}\n"}${viewModel?.order?.customerCompanyName?.isEmpty ?? true ? "" : "${AppString.companyText.tr}: ${viewModel?.order?.customerCompanyName}\n"}${viewModel?.order?.customerAddress ?? ""} \n${viewModel?.order?.customerCity ?? ""}, ${viewModel?.order?.customerPostcode ?? ""} ".replaceAll("Cancel: ", "")
                                                  : "${viewModel?.order?.customerAddress ?? ""}, ${viewModel?.order?.customerCity ?? ""}, ${viewModel?.order?.customerPostcode ?? ""} "),
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
                                                                  Colors.black,
                                                              fontSize: 15),
                                                      3.0.addWSpace(),
                                                      (viewModel.currency ?? "")
                                                          .appTextStyle400(
                                                              fontColor:
                                                                  Colors.black,
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
                          20.0.addHSpace()
                        ],
                      ).paddingSymmetric(horizontal: 10),
                    ))),
        );
      },
    );
  }

  Widget pricingCard({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.appTextStyle400(fontSize: 15),
        price.appTextStyle400(fontSize: 15),
      ],
    ).paddingOnly(bottom: 5);
  }
}
