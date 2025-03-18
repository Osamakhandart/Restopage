import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/shared_prefs.dart';

import '../../../constant/app_color.dart';
import '../../../widgets/app_app_bar.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String restName =
        preferences.getString(SharedPreference.REST_NAME, defValue: ".") ?? ".";
    final String ownerName =
        preferences.getString(SharedPreference.OWNER_NAME, defValue: ".") ??
            ".";
    final String address1 =
        preferences.getString(SharedPreference.ADDRESS_NO_1, defValue: ".") ??
            ".";
    final String ownerMobileNumber = preferences
            .getString(SharedPreference.OWNER_MOBILE_NO, defValue: ".") ??
        ".";
    final String restContactNumber = preferences.getString(
            SharedPreference.RESTO_CONTACT_MOBILE_NO,
            defValue: ".") ??
        ".";
    final String emailId =
        preferences.getString(SharedPreference.USER_EMAIL, defValue: ".") ??
            ".";
    // final String ownerName = preferences.getString(SharedPreference., defValue: ".") ?? ".";
    // final String location = preferences.getString(SharedPreference., defValue: ".") ?? ".";

    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.myAccountText.tr,
        leadingIcon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          5.0.addHSpace(),
          myAccountTile(title: restName, image: AppAssets.userImg),
          myAccountTile(title: ownerName, image: AppAssets.userImg),
          myAccountTile(title: address1, image: AppAssets.locationImg),
          myAccountTile(title: ownerMobileNumber, image: AppAssets.phoneImg),
          myAccountTile(title: restContactNumber, image: AppAssets.phoneImg),
          myAccountTile(title: emailId, image: AppAssets.emailImg),
          20.0.addHSpace(),
          AppString.accountDetailsText.tr
              .appTextStyle400(fontColor: greyColor, fontSize: 13)
        ],
      ).paddingSymmetric(horizontal: 15),
    );
  }

  Widget myAccountTile({required String title, required String image}) {
    return Column(
      children: [
        5.0.addHSpace(),
        Row(
          children: [
            assetImage(image, height: 20, width: 20),
            15.0.addWSpace(),
            Expanded(child: title.appTextStyle400(fontColor: greyColor))
          ],
        ),
        5.0.addHSpace(),
        1.0.appDivider(color: const Color(0xffe4e4e4))
      ],
    );
  }
}
