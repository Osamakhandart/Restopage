import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/models/user_model.dart';
import 'package:resto_page/theme/app_layout.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/utils/shared_prefs.dart';

import 'package:resto_page/api/repo/auth_repo.dart';
import 'package:resto_page/models/response_item.dart';
import 'package:resto_page/utils/push_notification_utils.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController forgetPassWordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> signIn(BuildContext context) async {
    // if (!emailController.text.trim().isValidEmail()) {
    //   showBottomSnackBar("Please enter valid email");
    // } else {
    hideKeyBoard(context);
    isLoading.value = true;
    ResponseItem result =
        ResponseItem(message: AppString.somethingWentWrongText.tr);
    result = await UserAuthRepo.userLogin(
        emailController.text.trim(), passWordController.text.trim());
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          var a=preferences.getString('deviceToken');
          print(a);
          UserResponseModel userRest = UserResponseModel.fromJson(result.data);
          preferences.saveUserItem(userRest.rest);
          NotificationUtils notificationUtils = NotificationUtils();
          await notificationUtils.init(false);
          print("Done");
          // Get.offAllNamed(Routes.homeScreen);
          update();
        }
      } else {
        showAppSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
    // }
  }

  Future<void> forgetPass(BuildContext context) async {
    if (!forgetPassWordController.text.trim().isValidEmail()) {
      showBottomSnackBar("Please enter valid email");
    } else {
      hideKeyBoard(context);
      isLoading.value = true;
      ResponseItem result =
          ResponseItem(message: AppString.somethingWentWrongText.tr);
      result = await UserAuthRepo.forgetPassword(
          forgetPassWordController.text.trim());
      try {
        if (result.status) {
          if (result.data != null) {
            try {
              isLoading.value = false;
              Get.offAllNamed(Routes.loginScreen);
              update();
            } catch (e) {
              isLoading.value = false;
            }
          }
        } else {
          showAppSnackBar(result.message!);
          // noAccountEmailBottomSheet(Get.context!);
          isLoading.value = false;
        }
      } catch (e) {
        isLoading.value = false;
        // showAppSnackBar(AppString.somethingWrongText.tr);
      }
      update();
    }
  }
}
