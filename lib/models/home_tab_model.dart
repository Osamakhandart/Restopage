import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/accepted_tab/accepted_tab.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/pending_tab/pending_tab.dart';
import 'package:resto_page/view/main/home_pages/home_tabs/rejected_tab/rejected_tab.dart';

import 'package:resto_page/view/main/home_pages/home_tabs/view_all_tab/view_all_tab.dart';


class PopUpList {
  String title;
  VoidCallback? onTap;

  PopUpList(
      {this.onTap, required this.title,  });
}


class AppTabBarModel {
  String tabText;
  Widget tabWidget;
  VoidCallback onTap;
  AppTabBarModel(
      {required this.tabText, required this.onTap, required this.tabWidget});
}

List<AppTabBarModel> homeTabList = [
  AppTabBarModel(
      tabText: AppString.viewAllText.tr,
      tabWidget: const ViewAllTab(),
      onTap: () {}),
  AppTabBarModel(
      tabText: AppString.pendingText.tr,
      tabWidget: const PendingTab(),
      onTap: () {}),
  AppTabBarModel(
      tabText: AppString.acceptedText.tr,
      tabWidget: const AcceptedTab(),
      onTap: () {}),
  AppTabBarModel(
      tabText: AppString.rejectedText.tr,
      tabWidget: const RejectedTab(),
      onTap: () {}),
];
