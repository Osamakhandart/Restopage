import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:resto_page/controllers/home_screen_controller.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/app_assets.dart';
import '../../../../constant/app_color.dart';
import '../../../../constant/app_string.dart';
import '../../../../widgets/app_app_bar.dart';

class TermScreen extends StatelessWidget {
  TermScreen({super.key});
  final homeScreenCtrl = Get.put(HomeScreenController());
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        titleText: AppString.termTitleText.tr,
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
              height: 150,
              color: drawerColor,
              child: assetImage(AppAssets.appLogo)
                  .paddingSymmetric(horizontal: 80),
            ),
            10.0.addHSpace(),
            Html(
                data: Get.locale?.languageCode == 'en'
                    ? homeScreenCtrl.term!.mobileTermsPageContentEnglish
                    : Get.locale?.languageCode == 'de'
                        ? homeScreenCtrl.term!.mobileTermsPageContentGermany
                        : homeScreenCtrl.term!.mobileTermsPageContentFrench,
                onLinkTap: (url, map, e) {
                  if (url != null) {
                    final Uri _url = Uri.parse(url);
                    print('it is terms $url');
                    _launchUrl(_url);
                  }
                }),
            // (Get.locale?.languageCode == 'en'
            //         ? _removeHtmlTagsFromString(
            //             homeScreenCtrl.term!.mobileTermsPageContentEnglish)
            //         : Get.locale?.languageCode == 'de'
            //             ? _removeHtmlTagsFromString(
            //                 homeScreenCtrl.term!.mobileTermsPageContentGermany)
            //             : _removeHtmlTagsFromString(
            //                 homeScreenCtrl.term!.mobileTermsPageContentFrench))
            //     .appTextStyle400(fontSize: 15)
            //     .paddingSymmetric(horizontal: 15),
            // AppString.termSubTitleText.tr
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
