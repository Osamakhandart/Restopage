import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';

import '../../../../utils/shared_prefs.dart';
import '../../../../widgets/app_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.languageText.tr,
        leadingIcon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          10.0.addHSpace(),
          languageTile(
              onTap: () {
                Get.updateLocale(const Locale("en", "US"));
                preferences.putString(SharedPreference.LANGUAGE_CODE, "en");
                preferences.putString(SharedPreference.COUNTRY_CODE, "US");
              },
              title: AppString.englishText.tr),
          1.0.appDivider(color: lightGreyColor),
          languageTile(
              onTap: () {
                Get.updateLocale(const Locale("de", "GER"));
                preferences.putString(SharedPreference.LANGUAGE_CODE, "de");
                preferences.putString(SharedPreference.COUNTRY_CODE, "GER");
              },
              title: AppString.germanText.tr),
          1.0.appDivider(color: lightGreyColor),
          languageTile(
              onTap: () {
                Get.updateLocale(const Locale("fr", "CH"));
                preferences.putString(SharedPreference.LANGUAGE_CODE, "fr");
                preferences.putString(SharedPreference.COUNTRY_CODE, "CH");
              },
              title: AppString.frenchText.tr),
          1.0.appDivider(color: lightGreyColor),
        ],
      ),
    );
  }

  Widget languageTile({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title.appTextStyle400().paddingSymmetric(horizontal: 10),
          ],
        ),
      ),
    );
  }
}
