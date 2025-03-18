import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_button.dart';

import '../../../../widgets/app_app_bar.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.feedBackTitleText.tr,
        leadingIcon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          10.0.addHSpace(),
          AppString.feedBackSubTitleText.tr
              .appTextStyle400(
                  fontColor: greyColor,
                  fontSize: 15,
                  textAlign: TextAlign.center)
              .paddingSymmetric(horizontal: 10),
          15.0.addHSpace(),
          AppButton(
            text: AppString.sendFeedbackText.tr,
            onTap: () {},
            color: greenColor,
          ),
        ],
      ).paddingSymmetric(horizontal: 15),
    );
  }
}
