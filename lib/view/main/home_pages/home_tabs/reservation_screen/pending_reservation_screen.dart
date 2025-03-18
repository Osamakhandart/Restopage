import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/accepted_tab/pick_up_time_screen.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/status_tab_controller.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_progress.dart';
import 'package:resto_page/utils/printer_class.dart';
import '../../../../../constant/app_assets.dart';
import '../../../../../constant/app_color.dart';
import '../../../../../constant/app_string.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../utils/shared_prefs.dart';
import '../../../../../widgets/app_app_bar.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_card.dart';

class PendingReservationScreen extends StatelessWidget {
  final statusViewController = Get.put(StatusViewController());
  final dynamic data = Get.arguments;
  PendingReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusViewController>(
      initState: (initState) => {

        Future.delayed(Duration.zero)
            .then((value) => statusViewController.getReservation(data["id"]))
      },
      builder: (statusViewController) {

        final reservation = statusViewController.reservationModel;

        return WillPopScope(
          onWillPop: () async  {
            Get.offAllNamed(Routes.homeScreen);
            return true;
          },
          child: Stack(
            children: [
              Scaffold(
                backgroundColor:
                reservation?.reservationSpecification == "virtual" ? red500Color : Colors.white,
                appBar: AppAppBar(
                  titleIcon: Column(children: [
                    ("#${reservation?.id ?? "71"}")
                        .appTextStyle400(fontColor: Colors.white),
                    (reservation?.date ?? "").appTextStyle400(fontColor: Colors.white, fontSize: 12),
                  ]),
                  leadingIcon: IconButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.homeScreen);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                bottomNavigationBar: Container(
                  height: 160,
                  color: reservation?.reservationSpecification != "virtual" ? Colors.white : red500Color,
                  child: Column(
                    children: [
                      reservation?.reservationSpecification != "virtual" ? Container() : testReservationCard(),
                      Column(
                        children: [
                          15.0.addHSpace(),
                          Row(
                            children: [
                              Expanded(
                                  child: AppButton(
                                    text: AppString.acceptButtonText.tr,
                                    onTap: () {
                                      
                                      // Get.toNamed(Routes.pickUpTimeScreen,arguments: {
                                      //   "id" : reservation?.id ?? ""
                                      // });
                                      Get.to(
                                          PickUpTimeScreen(
                                            id: reservation?.id ?? "",
                                            orderType: "reservation",
                                            orderTime: reservation?.createdAt ?? DateTime.now(),
                                            orderSpecification: reservation?.reservationSpecification ?? "", 
                                          ));
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
                                            "id": reservation?.id,
                                            "orderId": reservation?.id,
                                            "orderDurationTime": reservation?.date,
                                            "restId": preferences.getString(SharedPreference.REST_ID)!,
                                            "phoneNumber" : reservation?.telephone,
                                            "orderType" : "reservation"
                                          });
                                    },
                                    color: drawerColor,
                                  )),
                            ],
                          ),
                          20.0.addHSpace(),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AppButton(
                                      text: AppString.printButtonText.tr,
                                      onTap: () async{
                                        
                                      },
                                      width: 120),
                                  AppString.printerText.tr.buttonTextStyle400(
                                      fontColor: Colors.white, fontSize: 15)
                                ],
                              )).paddingSymmetric(horizontal: 15),
                        ],
                      ).paddingSymmetric(horizontal: 20)
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
                                    child:  const Row(
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
                                title: (reservation?.telephone ??
                                    "."),
                                image: AppAssets.phoneImg),
                            myAccountTile(
                                title: (reservation?.email ??
                                    "."),
                                image: AppAssets.emailImg),
                            myAccountTile(
                                title: ("${reservation?.numberOfPeople ?? ""} People" ??
                                    "."),
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


              Obx(() => statusViewController.isLoading.value ? const AppProgress() :const SizedBox())
            ],
          ),
        );
      },
    );
  }

}
