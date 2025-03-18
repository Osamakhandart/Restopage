import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/status_tab_controller.dart';
import 'package:resto_page/utils/extension.dart';

import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../widgets/app_card.dart';

class RejectedReservationScreen extends StatelessWidget {
  final statusViewController = Get.put(StatusViewController());
  final dynamic data = Get.arguments;

  RejectedReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusViewController>(
      initState: (initState) => {
        Future.delayed(Duration.zero)
            .then((value) => statusViewController.getReservation(data["id"]))
      },
      builder: (logic) {

        final reservation = statusViewController.reservationModel;

        return WillPopScope(
          onWillPop: () async  {
            Get.offAllNamed(Routes.homeScreen);
            return true;
          },
          child: Scaffold(
            backgroundColor:
            reservation?.reservationSpecification == "virtual" ? red500Color : Colors.white,
            appBar: AppAppBar(
              titleIcon: Column(children: [
                ("#${reservation?.id ?? "71"}")
                    .appTextStyle400(fontColor: Colors.white),
                (reservation?.date ?? "")
                    .appTextStyle400(
                    fontColor: Colors.white, fontSize: 12),
              ]),
              leadingIcon: IconButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.homeScreen);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),

            bottomNavigationBar: SizedBox(
              height: 20,
              child: reservation?.reservationSpecification == "virtual"  ? testReservationCard() : Container(),
            ).paddingOnly(bottom: reservation?.reservationSpecification == "virtual" ? 20 : 0),

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
                                child: const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,
                                  children: [

                                  ],
                                ).paddingOnly(right: 10))
                          ],
                        ),
                        8.0.addHSpace(),
                        myAccountTile(
                            title: ("${reservation?.firstName ?? "."} ${reservation?.lastName ?? "."}"),
                            image: AppAssets.userImg),
                        myAccountTile(
                            title: (reservation?.telephone ?? "."),
                            image: AppAssets.phoneImg),
                        myAccountTile(
                            title: (reservation?.email ??
                                "."),
                            image: AppAssets.emailImg),
                        myAccountTile(
                            title: ("${reservation?.numberOfPeople ?? ""} People" ?? "."),
                            image: AppAssets.peopleImg),
                        myAccountTile(
                            title: "${reservation?.date ?? ""} | ${reservation?.time ?? ""} ",
                            image: AppAssets.calenderImg,
                            showDivider: statusViewController.isNUllData ? false : true),
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
