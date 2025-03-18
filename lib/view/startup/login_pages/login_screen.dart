import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_progress.dart';

import '../../../constant/app_string.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_textfield.dart';
import '../../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: assetsImage2(AppAssets.loginBackgroundImg),
                  fit: BoxFit.fill,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height / 12,
                      ),
                      Container(
                        height: Get.height / 12,
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              speed: const Duration(milliseconds: 100),
                              textAlign: TextAlign.center,
                              AppString.loginTitleText.tr,
                              textStyle: TextStyle(
                                color: lightGreyColor.withOpacity(0.5),
                                fontStyle: FontStyle.italic,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            // TypewriterAnimatedText('Design first, then code'),
                            // TypewriterAnimatedText(
                            //     'Do not patch bugs out, rewrite them'),
                            // TypewriterAnimatedText(
                            //     'Do not test bugs out, design them out'),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                      // AppString.loginTitleText.tr
                      //     .appTextStyle400(
                      //         fontSize: 25,
                      //         textAlign: TextAlign.center,
                      //         fontColor: lightGreyColor.withOpacity(0.3))
                      //     .paddingSymmetric(horizontal: 10),
                      assetImage(AppAssets.appLogo, height: 150, width: 200),
                      50.0.addHSpace(),

                      LoginTextField(
                        hintText: AppString.yourEmailText.tr,
                        titleText: AppString.loginEmailText.tr,
                        controller: loginCtrl.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      15.0.addHSpace(),
                      LoginTextField(
                        hintText: AppString.subTitlePassText.tr,
                        titleText: AppString.titlePassText.tr,
                        keyboardType: TextInputType.emailAddress,
                        controller: loginCtrl.passWordController,
                      ),

                      30.0.addHSpace(),

                      ///
                      LoginButton(
                          appTile: AppString.loginText.tr,
                          onTap: () {
                            // showAppSnackBar("Email or password is wrong");

                            loginCtrl.signIn(context);
                            // Get.offAllNamed(Routes.homeScreen);
                          }),

                      ///
                      15.0.addHSpace(),
                      1.0.appDivider(),
                      5.0.addHSpace(),

                      ///

                      TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.forgetPasswordScreen);
                          },
                          child: AppString.forgetPassText.tr
                              .appTextStyle400(fontColor: Colors.white)),
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
