import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../widgets/app_app_bar.dart';
import '../../../../controllers/home_screen_controller.dart';

class AboutScreen extends StatelessWidget {
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  AboutScreen({super.key});
  final homeScreenCtrl = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.aboutTitleText.tr,
        leadingIcon: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              height: 150,
              color: drawerColor,
              child: assetImage(AppAssets.appLogo)
                  .paddingSymmetric(horizontal: 50),
            ),
            10.0.addHSpace(),
            Html(
                data: Get.locale?.languageCode == 'en'
                    ? homeScreenCtrl.about!.mobileAboutPageContentEnglish
                    : Get.locale?.languageCode == 'de'
                        ? homeScreenCtrl.about!.mobileAboutPageContentGermany
                        : homeScreenCtrl.about!.mobileAboutPageContentFrench,
                onLinkTap: (url, map, e) {
                  if (url != null) {
                    final Uri _url = Uri.parse(url);
                    _launchUrl(_url);
                  }
                }),
            // (Get.locale?.languageCode == 'en'
            //         ? _removeHtmlTagsFromString(
            //             homeScreenCtrl.about!.mobileAboutPageContentEnglish)
            //         : Get.locale?.languageCode == 'de'
            //             ? _removeHtmlTagsFromString(
            //                 homeScreenCtrl.about!.mobileAboutPageContentGermany)
            //             : _removeHtmlTagsFromString(
            //                 homeScreenCtrl.about!.mobileAboutPageContentFrench))
            //     .appTextStyle400(fontSize: 15)
            //     .paddingSymmetric(horizontal: 15)

            // AppString.aboutSubTitleText.tr
            //     .appTextStyle400(fontSize: 15)
            //     .paddingSymmetric(horizontal: 15)
          ],
        ),
      ),
    );
  }

  String _removeHtmlTagsFromString(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(exp, '');
  }
}
