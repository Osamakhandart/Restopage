import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../constant/app_assets.dart';
import '../../../constant/app_color.dart';
import '../../../constant/app_string.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_textfield.dart';
import '../../../controllers/login_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put(LoginController());
    return Container(
      color: appColor,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Scaffold(
              body: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: assetsImage2(AppAssets.loginBackgroundImg),
                  fit: BoxFit.fill,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height / 20,
                      ),
                      AppString.loginTitleText.tr
                          .appTextStyle400(
                              fontSize: 25,
                              textAlign: TextAlign.center,
                              fontColor: lightGreyColor.withOpacity(0.3))
                          .paddingSymmetric(horizontal: 10),
                      assetImage(AppAssets.appLogo, height: 150, width: 200),
                      50.0.addHSpace(),

                      LoginTextField(
                        hintText: AppString.yourEmailText.tr,
                        titleText: AppString.loginEmailText.tr,
                        keyboardType: TextInputType.emailAddress,
                        controller: loginCtrl.forgetPassWordController,
                      ),
                      5.0.addHSpace(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Routes.loginScreen);
                            },
                            child: AppString.loginHereText.tr.appTextStyle400(
                                fontColor: Colors.white, fontSize: 15),
                          )),

                      30.0.addHSpace(),

                      ///
                      LoginButton(
                          appTile: AppString.sendEmailText.tr,
                          onTap: () {
                            loginCtrl.forgetPass(context);
                          }),

                      ///

                      40.0.addHSpace(),
                    ],
                  ).paddingSymmetric(horizontal: 30),
                ),
              ),
            ),
            Obx(() =>
                loginCtrl.isLoading.value ? const AppProgress() : Container())
          ],
        ),
      ),
    );
  }
}
