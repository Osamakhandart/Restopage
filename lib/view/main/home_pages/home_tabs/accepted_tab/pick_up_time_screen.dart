import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/models/view_order_model.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/printer_class.dart';
import 'package:resto_page/utils/shared_prefs.dart';
import 'package:resto_page/widgets/app_app_bar.dart';
import 'package:resto_page/widgets/app_button.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../../../models/home_tab_model.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/app_popup_menu.dart';
import '../../../../../controllers/status_tab_controller.dart';

class PickUpTimeScreen extends StatefulWidget {
  // final id = Get.arguments;
  final String? id;
  final String? orderType;
  final DateTime orderTime;
  final String? orderSpecification;
   ViewOrderModel? viewModel;

   PickUpTimeScreen(
      {super.key,
      
      required this.orderTime,
      this.id,
      this.orderType,
      required this.orderSpecification,this.viewModel});

  @override
  State<PickUpTimeScreen> createState() => _PickUpTimeScreenState();
}

class _PickUpTimeScreenState extends State<PickUpTimeScreen> {
  final statusViewCtrl = Get.find<StatusViewController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StatusViewController>(
      builder: (statusViewController) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppAppBar(
                titleText: AppString.acceptText.tr,
                leadingIcon: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new)),
              ),
              body: Column(
                children: [
                  10.0.addHSpace(),
                  /*widget.orderType == "reservation" ? Row(
                    children: [
                      AppString.pickUpTimeText.tr
                          .appTextStyle400(fontSize: 18),
                      5.0.addWSpace(),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: const Color(0xfff5f5f5),
                          child: Center(
                            child: SizedBox(
                              width: 180,
                              child: textField(
                                  focusNode:
                                  statusViewController.inputNode,
                                  controller:
                                  statusViewController.timePickCtrl,
                                  onChanged: statusViewController.onChangeTextField,
                                  suffixIcon: PopupMenu(popUpList: [
                                    ...statusViewController.popUpList
                                        .map((e) => PopUpList(
                                        title: e.title,
                                        onTap: () {
                                          hideKeyBoard(context);
                                          if (e.title ==
                                              AppString
                                                  .otherText.tr) {
                                            FocusScope.of(context)
                                                .requestFocus(
                                                statusViewController
                                                    .inputNode);
                                            statusViewController
                                                .update();
                                          } else {
                                            FocusManager
                                                .instance.primaryFocus
                                                ?.unfocus();
                                            statusViewController
                                                .onChangeTimer(
                                                e.title);
                                          }
                                        }))
                                        .toList()
                                  ]).createPopup()),
                            ),
                          ),
                        ),
                      )
                      */
                  /*Expanded(
                        child: Container(
                          height: 50,
                          color: const Color(0xfff5f5f5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 5,
                                child: textField(
                                    controller:
                                    statusViewController.timePickCtrl,
                                    onChanged:
                                    statusViewController.onChangeTextField,
                                    suffixIcon: PopupMenu(
                                        popUpList: [
                                          ...statusViewController.popUpList
                                              .map((e) => PopUpList(
                                              title: e.title,
                                            onTap: () {
                                                statusViewController.onChangeTimer(e.title);
                                            }
                                          )).toList()
                                        ]

                                    ).createPopup()

                                ),
                              ),

                              // AppDropDownWidget(
                              //   items: statusViewController.timerList,
                              //   value: statusViewController.selectedTime,
                              //   onChanged: statusViewController.onChangeTimer,
                              // ).paddingSymmetric(horizontal: 55),
                            ],
                          ).paddingSymmetric(horizontal: 20),
                        ),
                      )*/ /*
                    ],
                  ) :*/

                  // widget.orderType == "reservation"
                  //     ? Container()
                  //     :
                  // widget.orderSpecification == "pre" || widget.orderSpecification == "real"
                  //     ?

                  widget.orderType == "reservation"
                      ? Container()
                      : widget.orderSpecification == "pre"
                          ? Container()
                          : Row(
                              children: [
                                (widget.orderType == "delivery"
                                        ? AppString.deliveryTimeText.tr
                                        : AppString.pickUpTimeText.tr)
                                    .appTextStyle400(fontSize: 17),
                                5.0.addWSpace(),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    color: const Color(0xfff5f5f5),
                                    child: Center(
                                      child: SizedBox(
                                        width: 180,
                                        child: textField(
                                            focusNode:
                                                statusViewController.inputNode,
                                            controller: statusViewController
                                                .timePickCtrl,
                                            onChanged: statusViewController
                                                .onChangeTextField,
                                            suffixIcon: PopupMenu(popUpList: [
                                              ...statusViewController.popUpList
                                                  .map((e) => PopUpList(
                                                      title: e.title,
                                                      onTap: () {
                                                        hideKeyBoard(context);
                                                        if (e.title ==
                                                            AppString
                                                                .otherText.tr) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  statusViewController
                                                                      .inputNode);
                                                          statusViewController
                                                              .update();
                                                        } else {
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                          statusViewController
                                                              .onChangeTimer(
                                                                  e.title);
                                                        }
                                                      }))
                                                  .toList()
                                            ]).createPopup()),
                                      ),
                                    ),
                                  ),
                                )
                                /*Expanded(
                        child: Container(
                          height: 50,
                          color: const Color(0xfff5f5f5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 5,
                                child: textField(
                                    controller:
                                    statusViewController.timePickCtrl,
                                    onChanged:
                                    statusViewController.onChangeTextField,
                                    suffixIcon: PopupMenu(
                                        popUpList: [
                                          ...statusViewController.popUpList
                                              .map((e) => PopUpList(
                                              title: e.title,
                                            onTap: () {
                                                statusViewController.onChangeTimer(e.title);
                                            }
                                          )).toList()
                                        ]

                                    ).createPopup()

                                ),
                              ),

                              // AppDropDownWidget(
                              //   items: statusViewController.timerList,
                              //   value: statusViewController.selectedTime,
                              //   onChanged: statusViewController.onChangeTimer,
                              // ).paddingSymmetric(horizontal: 55),
                            ],
                          ).paddingSymmetric(horizontal: 20),
                        ),
                      )*/
                              ],
                            ),
                  30.0.addHSpace(),
                  AppButton(
                      text: AppString.acceptAndConfirmText.tr,
                      onTap: () async {
                        try {
                          print(statusViewController.duration.toString());
                          await statusViewController.acceptOrder(
                            orderId: widget.id ??
                                statusViewController
                                    .viewOrderModel?.order?.orderId ??
                                "",
                            restId: preferences
                                .getString(SharedPreference.REST_ID)!,
                            //duration
                            orderDurationTime:
                                statusViewController.duration.toString(),
                            orderType: widget.orderType ?? "",
                          );

                          if (widget.orderType == "reservation") {
                            Get.offAllNamed(Routes.accptedReservationScreen,
                                arguments: {
                                  "id": widget.id,
                                  "isTested": false,
                                });
                          } else {
                                        if(Platform.isAndroid){
                                 if(widget.orderSpecification != "pre"){
                                  print(statusViewController.duration.toString());
                                    statusViewController.checkIfPosDevice(widget.viewModel!,prepareDuration: statusViewController.duration.toString());}
                             
                                 else{
                          statusViewController.checkIfPosDevice(widget.viewModel!);}

                                 }

                            Get.offAllNamed(Routes.acceptedViewScreen,
                                arguments: {
                                  "id": widget.id,
                                  "isTested": false,
                                  "preOrder": "Virtual",
                                  "orderStatus": "reservation"
                                });
                                 
                             
                      
                          }}
                        catch (e) {}
                      },
                      color: greenColor),
                  20.0.addHSpace(),
                  (widget.orderType == "pickup"
                          ? AppString.pickTimeSubText.tr
                          : widget.orderType == "delivery"
                              ? AppString.deliveryTimeSubText.tr
                              : AppString.reservationTimeSubText.tr)
                      .appTextStyle400()
                ],
              ).paddingSymmetric(horizontal: 15),
            ),
            Obx(() => statusViewController.isLoading.value
                ? const AppProgress()
                : Container())
          ],
        );
      },
    );
  }

  Widget textField(
      {required TextEditingController controller,
      required ValueChanged<String> onChanged,
      required Widget suffixIcon,
      FocusNode? focusNode}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: controller,
            onChanged: onChanged,
            focusNode: focusNode,
            decoration: const InputDecoration(
              // suffixIcon: suffixIcon,
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: AppString.minText.tr
                .appTextStyle400(textAlign: TextAlign.start)
                .paddingOnly(top: 2)),
        suffixIcon
      ],
    );
  }
}
