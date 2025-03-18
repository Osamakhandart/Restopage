import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_page/constant/app_assets.dart';
import 'package:resto_page/constant/app_string.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/extension.dart';
import 'package:resto_page/widgets/app_dropdown_widget.dart';

import '../../../constant/app_color.dart';
import '../../../models/home_tab_model.dart';
import '../../../widgets/app_button.dart';
import '../../../controllers/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {



@override
  void initState() {
    // TODO: implement initState
       super.initState();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
    @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
   final homeScreenCtrl = Get.put(HomeScreenController());
      @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      homeScreenCtrl.getViewAll();
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        // throw UnimplementedError();
    }
    
}
 
    final GlobalKey<SliderDrawerState> sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      // initState: (initState) => {
      // Future.delayed(Duration.zero)
      //     .then((value) => homeScreenCtrl.getOpenTime()),
      // },
      builder: (homeCtrl) {
        return Scaffold(
          body: Container(
            color: appColor,
            child: SafeArea(
              bottom: false,
              child: GestureDetector(
                onTap: () {
                  closeDrawer();
                },
                child: Scaffold(
                  body: SliderDrawer(
                    splashColor: drawerColor,
                    key: sliderDrawerKey,
                    appBar: appBar(),
                    slider: homeDrawer(homeCtrl),
                    child: Stack(
                      children: [
                        DefaultTabController(
                            length: 4,
                            child: Stack(
                              children: [
                                TabBar(
                                  onTap: (v) {
                            
                                    homeScreenCtrl.currentTab = v;
                                  },
                                  indicatorColor: appColor,
                                  labelColor: appColor,
                                  indicatorWeight: 1,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  unselectedLabelStyle: GoogleFonts.poppins(
                                      color: appColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  labelStyle: GoogleFonts.poppins(
                                      color: appColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                  tabs: homeTabList
                                      .map((e) => Tab(text: e.tabText))
                                      .toList(),
                                ),
                                TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: homeTabList
                                            .map((e) => e.tabWidget)
                                            .toList())
                                    .paddingOnly(top: 48)
                              ],
                            )),
                        homeCtrl.isDrawerOpen
                            ? GestureDetector(
                                onTap: () {
                                  closeDrawer();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: Get.height,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget appBar() {
    return AppBar(
      titleSpacing: -2,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor:
          homeScreenCtrl.isDrawerOpen ? const Color(0xff1795d5) : appColor,
      // toolbarHeight: 40,
      title: AppString.myOrderReservationText.tr
          .appTextStyle500(fontColor: Colors.white, fontSize: 16),
      leading: IconButton(
          onPressed: () {
            if (sliderDrawerKey.currentState!.isDrawerOpen) {
              homeScreenCtrl.isDrawerOpen = false;
              homeScreenCtrl.update();
              sliderDrawerKey.currentState?.closeSlider();
            } else {
              homeScreenCtrl.isDrawerOpen = true;
              homeScreenCtrl.update();
              sliderDrawerKey.currentState?.openSlider();
            }
          },
          icon: const Icon(Icons.dehaze)),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: AppString.quantity.tr
              .appTextStyle500(fontColor: Colors.white, fontSize: 14),
        ),

        SizedBox(
          width: 10,
        ),
        AppDropDownWidget(
          items: homeScreenCtrl.dropdownOptions,
          value: homeScreenCtrl.dropdownValue,
          onChanged: (v) {
            homeScreenCtrl.onDropDownChange(v);
          },
        ),
        SizedBox(
          width: 10,
        ),
        // IconButton(
        //     onPressed: () {
        //       Get.toNamed(Routes.infoScreen);
        //     },
        //     icon: const Icon(
        //       Icons.info_outline,
        //       color: Colors.white,
        //     ))
      ],
    );
  }

  Widget homeDrawer(controller) {
    return GestureDetector(
      onTap: () {
        closeDrawer();
      },
      child: Drawer(
        elevation: 0,
        backgroundColor: drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ORDER TILE
            15.0.addHSpace(),
            drawerDivider(AppString.orderText.tr),
            drawerListTile(
                title: AppString.myOrderReservationText.tr,
                onTap: () {
                  closeDrawer();
                },
                image: AppAssets.cartImg),
            // drawerListTile(
            //     title: AppString.newTestOrderText.tr,
            //     onTap: () {
            //       closeDrawer();
            //       Get.toNamed(Routes.newTestOrderScreen);
            //     },
            //     image: AppAssets.cartImg),
            10.0.addHSpace(),

            /// SETTINGS TILE
            drawerDivider(AppString.settingText.tr),
            // drawerListTile(
            //     title: AppString.feedBackTitleText.tr,
            //     onTap: () {
            //       closeDrawer();
            //       Get.toNamed(Routes.feedbackScreen);
            //     },
            //     image: ""),
            drawerListTile(
                title: AppString.aboutTitleText.tr,
                onTap: () {
                  closeDrawer();
                  Get.toNamed(Routes.aboutScreen);
                },
                image: ""),
            drawerListTile(
                title: AppString.termTitleText.tr,
                onTap: () {
                  closeDrawer();
                  Get.toNamed(Routes.termScreen);
                },
                image: ""),
            drawerListTile(
                title: AppString.languageText.tr,
                onTap: () {
                  closeDrawer();
                  Get.toNamed(Routes.languageScreen);
                },
                image: ""),

            10.0.addHSpace(),

            /// PRINTER TILE
            // drawerDivider(AppString.printerText.tr),
            // drawerListTile(
            //     title: AppString.thermalPrinterText.tr,
            //     onTap: () {
            //       closeDrawer();
            //     },
            //     image: ""),

            /// ACCOUNT TILE
            drawerDivider(AppString.accountText.tr),
            drawerListTile(
                title: AppString.myAccountText.tr,
                onTap: () {
                  closeDrawer();
                  Get.toNamed(Routes.myAccountScreen);
                },
                image: AppAssets.userImg),
            drawerListTile(
                title: AppString.logOutText.tr,
                onTap: () {
                  // preferences.logOut();
                  closeDrawer();
                  logOutDialogBox(context, controller);
                },
                image: ""),
            drawerListTile(
                title: '${AppString.appVersion.tr}: 1.0.4',
                onTap: () {
                  // preferences.logOut();
                },
                image: ""),
          ],
        ).paddingSymmetric(horizontal: 15),
      ),
    );
  }

  closeDrawer() {
    homeScreenCtrl.isDrawerOpen = false;
    sliderDrawerKey.currentState?.closeSlider();
    homeScreenCtrl.update();
  }

  Widget drawerDivider(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.appTextStyle400(fontColor: greyColor, fontSize: 15),
        1.0.appDivider(color: greyColor),
        5.0.addHSpace()
      ],
    );
  }

  drawerListTile(
      {required String title,
      required String image,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            image == ""
                ? const SizedBox(
                    width: 20,
                    height: 20,
                  )
                : assetImage(image, height: 20, width: 20, color: greyColor),
            15.0.addWSpace(),
            Expanded(
                child: title.appTextStyle400(
                    fontColor: Colors.white, fontSize: 15))
          ],
        ),
      ),
    );
  }

  logOutDialogBox(BuildContext context, HomeScreenController controller) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: Stack(
              children: <Widget>[
                AppString.logOutText.tr.appTextStyle600(
                  fontColor: const Color(0xffEF5F5F),
                ),
                AppString.sureLogOutText.tr
                    .appTextStyle400()
                    .paddingOnly(top: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextButton(
                      onTap: () {
                        Get.back();
                      },
                      title: AppString.cancelText.tr,
                    ),
                    Obx(
                      () => controller.logoutLoader.value
                          ? Container(
                              width: 50,
                              height: 50,
                              color: Colors.white.withOpacity(0.5),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      color: appColor)))
                          : AppTextButton(
                              onTap: () {
                                controller.signOut(context);
                              },
                              textColor: const Color(0xffEF5F5F),
                              splashColor: Colors.red.shade50,
                              title: AppString.logOutText.tr,
                            ),
                    ),
                  ],
                ).paddingOnly(top: 75)
              ],
            ),
          );
        });
  }
}
