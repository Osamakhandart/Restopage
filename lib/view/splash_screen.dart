import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/push_notification_utils.dart';
import 'package:resto_page/utils/shared_prefs.dart';

import '../constant/app_assets.dart';
import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String languageCode =
      preferences.getString(SharedPreference.LANGUAGE_CODE, defValue: "en") ??
          "en";
  String countryCode =
      preferences.getString(SharedPreference.LANGUAGE_CODE, defValue: "US") ??
          "US";

  _onInit() async {
    await NotificationUtils().init(true);
    await FirebaseMessaging.instance.requestPermission();
    Get.updateLocale(Locale(languageCode, countryCode));
    setState(() {});
    Future.delayed(const Duration(seconds: 3), () {
      if (preferences.getBool(SharedPreference.IS_LOGGED_IN) ?? false) {
        print('going to home screen from splash');

        Get.offAllNamed(Routes.homeScreen);
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
    });
  }

  @override
  void initState() {
    _onInit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: appColor,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            // backgroundColor: greyColor,
            //const Color(0xfff5f5f5),
            body: Container(
              height: Get.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: assetsImage2(AppAssets.loginBackgroundImg),
                fit: BoxFit.fill,
              )),
              child: Center(child: assetImage(AppAssets.appLogo))
                  .paddingSymmetric(horizontal: 50),
            ),
          ),
        ));
  }
}
