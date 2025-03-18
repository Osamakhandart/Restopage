import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/utils/extension.dart';

showAppSnackBar(
  String tittle,
) {
  return Get.showSnackbar(GetSnackBar(
      messageText: Text(
        // "Email or password is wrong",
        tittle,
        style: const TextStyle(color: Colors.white),
      ),
      borderRadius: 0,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      shouldIconPulse: false,
      icon: Container(
        height: 25,
        width: 25,
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: const Center(
          child: Icon(
            Icons.close_rounded,
            color: snackBarColor,
          ),
        ),
      ),
      backgroundColor: snackBarColor,
      duration: const Duration(seconds: 3)));
}

showBottomSnackBar(String tittle) {
  return Get.showSnackbar(GetSnackBar(
    // message: tittle,
    messageText: tittle.appTextStyle400(fontColor: Colors.white),
    borderRadius: 15,

    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    shouldIconPulse: false,
    icon: const Icon(
      Icons.error_outline,
      color: Colors.white,
    ),
    backgroundColor: snackBarColor,
    duration: const Duration(seconds: 3),
  ));
}
