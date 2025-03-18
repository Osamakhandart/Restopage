import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/controllers/home_screen_controller.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/status_tab_controller.dart';
import 'package:resto_page/utils/extension.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../utils/shared_prefs.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_card.dart';

class AccptedReservationScreen extends StatelessWidget {
  final statusViewController = Get.put(StatusViewController());

  final dynamic data = Get.arguments;
  AccptedReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.put(HomeScreenController());
    return GetBuilder<StatusViewController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => statusViewController.getReservation(data["id"]))
      },
      builder: (logic) {
        final reservation = statusViewController.reservationModel;

        return WillPopScope(
          onWillPop: () async {
            Get.offAllNamed(Routes.homeScreen);
            return true;
          },
          child: Scaffold(
            backgroundColor: reservation?.reservationSpecification == "virtual"
                ? red500Color
                : Colors.white,
            appBar: AppAppBar(
              titleIcon: Column(children: [
                ("#${reservation?.id ?? "71"}")
                    .appTextStyle400(fontColor: Colors.white),
                (reservation?.date ?? "")
                    .appTextStyle400(fontColor: Colors.white, fontSize: 12),
              ]),
              leadingIcon: IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.homeScreen);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            bottomNavigationBar: Container(
              height: 220,
              color: reservation?.reservationSpecification != "virtual"
                  ? Colors.white
                  : red500Color,
              child: Column(
                children: [
                  reservation?.reservationSpecification != "virtual"
                      ? Container()
                      : testReservationCard(),
                  10.0.addHSpace(),
                  AppString.customerReceiveEmailText.tr
                      .appTextStyle600(
                          fontColor: greyColor,
                          fontSize: 14,
                          textAlign: TextAlign.center)
                      .paddingSymmetric(horizontal: 15),
                  10.0.addHSpace(),
                  AppButton(
                    text: AppString.rejectButtonText.tr,
                    onTap: () {
                      Get.toNamed(Routes.rejectOrderScreen, arguments: {
                        "id": data["id"],
                        "orderDurationTime": reservation?.date,
                        "restId":
                            preferences.getString(SharedPreference.REST_ID),
                        "orderType": "reservation",
                        // "phoneNumber" : reservationModel?.telephone
                      });
                    },
                    color: drawerColor,
                  ).paddingSymmetric(horizontal: 15),
                  15.0.addHSpace(),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Stack(
                  //       alignment: Alignment.center,
                  //       children: [
                  //         AppButton(
                  //             text: AppString.printButtonText.tr,
                  //             onTap: () {},
                  //             width: 120),
                  //         AppString.printerText.tr.buttonTextStyle400(
                  //             fontColor: Colors.white, fontSize: 15)
                  //       ],
                  //     )).paddingSymmetric(horizontal: 15),
                ],
              ),
            ),
            body: SingleChildScrollView(
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
                                  color: greenColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12))),
                              height: 50,
                              child: AppString.accepted2Text.tr
                                  .appTextStyle400(fontColor: Colors.white)
                                  .paddingOnly(top: 15, left: 15),
                            )),
                            Expanded(child: Container().paddingOnly(right: 10))
                          ],
                        ),
                        8.0.addHSpace(),
                        myAccountTile(
                            title:
                                ("${reservation?.firstName ?? "."} ${reservation?.lastName ?? "."}"),
                            image: AppAssets.userImg),
                        myAccountTile(
                            title: (reservation?.telephone ?? "."),
                            image: AppAssets.phoneImg),
                        myAccountTile(
                            title: (reservation?.email ?? "."),
                            image: AppAssets.emailImg),
                        myAccountTile(
                            title:
                                ("${reservation?.numberOfPeople ?? ""} People" ??
                                    "."),
                            image: AppAssets.peopleImg),
                        myAccountTile(
                            title:
                                "${reservation?.date ?? ""} | ${reservation?.time ?? ""} ",
                            image: AppAssets.calenderImg,
                            showDivider:
                                statusViewController.isNUllData ? false : true),
                        myAccountTile(
                            title: (reservation?.remark ?? "."),
                            image: "",
                            showDivider: false),
                        // statusViewController.isNUllData
                        //     ? Container()
                        //     : myAccountTile(
                        //     title:
                        //     (viewModel?.order?.orderRemark ??
                        //         "."),
                        //     image: "",
                        //     showDivider: false),
                        // "Welcome to our restaurant"
                        //     .appTextStyle400(fontColor: greyColor)
                        //     .paddingOnly(left: 45),
                        15.0.addHSpace(),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
