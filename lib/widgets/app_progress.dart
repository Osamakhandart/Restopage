import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: Get.height,
        color: Colors.white.withOpacity(0.5),
        child: const Center(child: CircularProgressIndicator(color: appColor)));
  }
}

class AppProgress2 extends StatelessWidget {
  const AppProgress2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: appColor));
  }
}
