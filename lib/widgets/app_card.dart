import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/reverse_timer.dart';

import '../constant/app_assets.dart';
import '../constant/app_color.dart';
import '../constant/app_string.dart';
import '../models/view_order_model.dart';
import '../controllers/home_screen_controller.dart';

class ReservationCard extends StatelessWidget {
  final bool isTested;
  final String image;
  final String personNumber;
  final String status;
  final String remainingTime;
  final String subTitle;
  final String remainingAfterAccept;
  final String specification;
  final DateTime? orderTime;
  final String orderType;

  const ReservationCard({
    super.key,
    required this.isTested,
    required this.remainingAfterAccept,
    required this.specification,
    required this.image,
    required this.status,
    required this.remainingTime,
    required this.subTitle,
    required this.personNumber,
    required this.orderType,
    this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    final homeScreenCtrl = Get.find<HomeScreenController>();
    // String date = homeScreenCtrl.convertDateTimeFormat(subTitle);
    print(subTitle);
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3, right: 4),
            child: Container(
              decoration: BoxDecoration(
                  color: status == AppString.pendingText.tr ||
                          status == AppString.pending2Text.tr
                      ? Colors.red.withOpacity(0.2)
                      : status == AppString.accepted2Text.tr ||
                              status == AppString.acceptedText.tr
                          ? Colors.green.withOpacity(0.2)
                          : Colors.black.withOpacity(0.2),
                  //color: isTested ? const Color(0xfffce4e0) : Colors.blue,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              height: 90,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 88,
                    width: 100,
                    decoration: const BoxDecoration(
                        color: drawerColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Stack(
                      children: [
                        Center(
                          child: assetImage(image, color: Colors.white)
                              .paddingAll(22),
                        ),
                        status != "Accepted"
                            ? Container()
                            : remainingAfterAccept == "" ||
                                    remainingAfterAccept == "0"
                                ? Container()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      remainingAfterAccept == null ||
                                              remainingAfterAccept!
                                                  .contains("-") ||
                                              remainingAfterAccept == 'null'
                                          ? Container()
                                          : Container(
                                              height: 15,
                                              decoration: const BoxDecoration(
                                                  color: greyColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              // child: Center(
                                              //   child: "00:00:00".appTextStyle400(
                                              //       fontColor: Colors.white, fontSize: 11),
                                              // ),
                                              child: DeliveryTimer(
                                                  dateTime:
                                                      remainingAfterAccept ??
                                                          "0"),
                                            )
                                      // RemainingTimer(dateTime: leftTime!)
                                    ],
                                  )
                      ],
                    ),
                  ),
                  10.0.addWSpace(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  assetImage(AppAssets.peopleImg,
                                      height: 15, width: 15),
                                  5.0.addWSpace(),
                                  Expanded(
                                      child: personNumber.appTextStyle400(
                                          fontColor: status == "Canceled"
                                              ? Colors.black
                                              : Colors.black,
                                          weight: FontWeight.w400,
                                          fontSize: 13,
                                          textOverflow: TextOverflow.ellipsis))
                                ],
                              ),
                            ),

                            /* status == "Pending" && specification == "pre"
                                ?  Row(
                                     children: [
                                       assetImage(AppAssets.stopwatchImg, height: 18, width: 18),
                                       5.0.addWSpace(),
                                       DeliveryTimer(
                                         dateTime: remainingTime,
                                         textColor: greyColor,
                                       ),
                                     ],
                                   ).paddingOnly(right: 10)
                                :  status == "Pending"
                                ?
                            PreOrderTimer(
                              placedOrderDate: orderTime,
                              orderType: orderType
                            )
                                :
                            remainingTime == null || remainingTime == "" ||remainingTime == "0"
                                ? Container()
                                : Row(
                                  children: [
                                    assetImage(AppAssets.stopwatchImg, height: 18, width: 18),
                                    5.0.addWSpace(),
                                    DeliveryTimer(
                                      dateTime: remainingTime,
                                        textColor: greyColor,
                                      ),
                                  ],
                                ).paddingOnly(right: 10)*/

                            remainingTime == "0" || remainingTime == ""
                                ? Container()
                                : status == "Pending"
                                    ? Row(
                                        children: [
                                          assetImage(AppAssets.stopwatchImg,
                                              height: 18, width: 18),
                                          5.0.addWSpace(),
                                          DeliveryTimer(
                                            dateTime: remainingTime,
                                            textColor: greyColor,
                                          ),
                                        ],
                                      ).paddingOnly(right: 10)
                                    : Container()
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: isTested
                                  ? const Color(0xffffcdd2)
                                  : const Color(0xfff5f5f5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    assetImage(
                                        remainingTime == ""
                                            ? AppAssets.calenderImg
                                            : AppAssets.coinImg,
                                        height: 20,
                                        width: 20),
                                    5.0.addWSpace(),
                                    subTitle.appTextStyle400(fontSize: 12)
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: status == AppString.pendingText.tr ||
                          status == AppString.pending2Text.tr
                      ? const Color(0xffef5350)
                      : status == AppString.accepted2Text.tr ||
                              status == AppString.acceptedText.tr
                          ?  greenColor
                          :  drawerColor,
                          
                          
               
                                      borderRadius: BorderRadius.circular(4)),
                                  child: status.appTextStyle400(
                                      fontSize: 12, fontColor: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ).paddingOnly(right: 10)
                      ],
                    ),
                  )
                ],
              ).paddingSymmetric(vertical: 8),
            ),
          ),
        ),
        isTested ? testReservationCard() : Container()
      ],
    );
  }
}

Widget myAccountTile(
    {required String title, required String image, bool showDivider = true}) {
  return Column(
    children: [
      5.0.addHSpace(),
      Row(
        children: [
          image == ""
              ? const SizedBox(
                  height: 20,
                  width: 20,
                )
              : assetImage(image, height: 20, width: 20),
          15.0.addWSpace(),
          Expanded(child: title.appTextStyle400(fontColor: greyColor))
        ],
      ),
      1.0.addHSpace(),
      showDivider ? 1.0.appDivider(color: const Color(0xffe4e4e4)) : Container()
    ],
  ).paddingSymmetric(horizontal: 10);
}

Widget testReservationCard() {
  return Container(
    height: 12,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 1),
    color: Colors.red,
    child: Center(
        child: AppString.pickOrder30MinitueText.tr
            .appTextStyle400(fontColor: Colors.white, fontSize: 9)),
  );
}

Widget detailsCard({required Widget child}) {
  return Container(
    decoration: BoxDecoration(boxShadow: const [
      BoxShadow(
          color: Colors.grey,
          blurRadius: 2,
          spreadRadius: 0.05,
          offset: Offset(0.0, 1))
    ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
    child: child,
  ).paddingSymmetric(horizontal: 5);
}

List<Widget> _getExtraItems(Map<String, dynamic>? extraFoodItems, currency) {
  if (extraFoodItems == null) return [];
  List<Widget> _extraFoodList = [];
  extraFoodItems.forEach((key, value) {
    _extraFoodList.add(
        "$key: $value $currency${_extraFoodList.length == extraFoodItems.length - 1 ? '' : ','} "
            .appTextStyle400(isItalic: true, fontSize: 14));
  });
  return _extraFoodList;
}

String removeSupTags(String? input) {
  // Regular expression to match <sup>...</sup>
  RegExp regExp = RegExp(r'<sup>.*?<\/sup>');

  // Replace matches with an empty string
  String cleanedString = input!.replaceAll(regExp, '');

  return cleanedString;
}

Widget itemsCard(List<Item>? items,
    {required String currency, required context}) {
  return Column(
    children: [
      ...?items
          ?.map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child:
                                ("${e.itemData?.qty} X ${removeSupTags(e.itemData?.itemName)} "
                                            "${e.itemData?.priceTitle}: ${e.itemData?.price} ${currency}" ??
                                        "" ??
                                        "")
                                    .appTextStyle400(
                                        fontColor: Colors.black,
                                        fontSize: 14,
                                        weight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child:
                                  ("${e.itemData?.itemTotal} X $currency" ?? "")
                                      .appTextStyle400(
                                          fontColor: Colors.black,
                                          fontSize: 15,
                                          weight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       child:
                  //           ("${e.itemData?.qty} X ${e.itemData?.itemName}" ??
                  //                   "")
                  //               .appTextStyle400(
                  //                   fontColor: Colors.black, fontSize: 15),
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //     ),
                  //     ("${e.itemData?.itemTotal} X $currency" ?? "")
                  //         .appTextStyle400(
                  //             fontColor: Colors.black, fontSize: 15)
                  //   ],
                  // ),
                  // ("${e.itemData?.priceTitle} ${e.itemData?.priceTitle} - ${e.itemData?.price} ${currency}" ??
                  //         "")
                  //     .appTextStyle400(fontColor: Colors.black, fontSize: 15),

                  /// EXTRA FOOD
                  10.0.addHSpace(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.45,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      children: _getExtraItems(e.itemData?.foodExtra, currency),
                    ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     ("Extras:").appTextStyle400(
                  //         fontColor: Colors.black, fontSize: 15),
                  //     10.0.addWSpace(),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: _getExtraItems(e.itemData?.foodExtra),
                  //     )
                  //   ],
                  // ),
                  15.0.addHSpace(),
                ],
              ))
          .toList()
    ],
  );
}
