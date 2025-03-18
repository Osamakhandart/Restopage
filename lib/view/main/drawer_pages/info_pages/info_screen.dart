import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_app_bar.dart';

import '../../../../widgets/app_button.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar(
          leadingIcon: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              )),
          titleText: AppString.infoTitleText.tr,
        ),
        body: Column(
          children: [
            10.0.addHSpace(),
            AppString.infoSubTitleText.tr
                .appTextStyle400(fontColor: Color(0xff616161), fontSize: 19)
                .paddingSymmetric(horizontal: 20),
            20.0.addHSpace(),
            assetImage(AppAssets.dontMissImg).paddingSymmetric(horizontal: 15),
            20.0.addHSpace(),
            AppButton(
              onTap: () {
                Get.back();
              },
              text: AppString.okGotItText.tr,
            ).paddingSymmetric(horizontal: 100),
          ],
        ));
  }
}
