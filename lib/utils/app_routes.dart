import 'package:get/get.dart';
import 'package:resto_page/view/startup/login_pages/login_screen.dart';

import '../view/main/drawer_pages/about_pages/about_screen.dart';
import '../view/main/drawer_pages/feed_back_pages/feed_back_screen.dart';
import '../view/main/drawer_pages/info_pages/info_screen.dart';
import '../view/main/drawer_pages/language_pages/language_screen.dart';
import '../view/main/drawer_pages/my_account_pages.dart';
import '../view/main/drawer_pages/new_test_order_pages/new_test_order_screen.dart';
import '../view/main/drawer_pages/term_pages/term_screen.dart';
import '../view/main/home_pages/home_screen.dart';
import '../view/main/home_pages/home_tabs/accepted_tab/accepted_view_screen.dart';
import '../view/main/home_pages/home_tabs/pending_tab/pending_view_screen.dart';
import '../view/main/home_pages/home_tabs/rejected_tab/reject_order_screen.dart';
import '../view/main/home_pages/home_tabs/rejected_tab/rejected_view_screen.dart';
import '../view/main/home_pages/home_tabs/reservation_screen/accepted_reservation_screen.dart';
import '../view/main/home_pages/home_tabs/reservation_screen/pending_reservation_screen.dart';
import '../view/main/home_pages/home_tabs/reservation_screen/rejected_reservation_screen.dart';
import '../view/splash_screen.dart';
import '../view/startup/forget_password_pages/forget_password_screen.dart';

class Routes {
  static String splashScreen = "/";
  static String loginScreen = "/loginScreen";
  static String forgetPasswordScreen = "/forgetPasswordScreen";
  static String homeScreen = "/homeScreen";
  static String homeScreenRefresh = "/homeScreen";
  static String infoScreen = "/infoScreen";
  static String newTestOrderScreen = "/newTestOrderScreen";
  static String feedbackScreen = "/feedbackScreen";
  static String aboutScreen = "/aboutScreen";
  static String languageScreen = "/languageScreen";
  static String myAccountScreen = "/myAccountScreen";
  static String pendingViewScreen = "/pendingViewScreen";
  static String acceptedViewScreen = "/acceptedViewScreen";
  static String rejectedViewScreen = "/rejectedViewScreen";
  static String rejectOrderScreen = "/rejectOrderScreen";
  static String termScreen = "/termScreen";
  static String reservationScreen = "/reservationScreen";
  static String accptedReservationScreen = "/accptedReservationScreen";
  static String rejectedReservationScreen = "/rejectedReservationScreen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: Routes.homeScreenRefresh, page: () => HomeScreen(),transition: Transition.noTransition),

    GetPage(
        name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen(),transition: Transition.noTransition),
    GetPage(
        name: infoScreen,
        page: () => const InfoScreen(),
        transition: Transition.downToUp),
    GetPage(name: newTestOrderScreen, page: () => NewTestOrderScreen()),
    GetPage(name: feedbackScreen, page: () => const FeedbackScreen()),
    GetPage(name: aboutScreen, page: () => AboutScreen()),
    GetPage(name: languageScreen, page: () => const LanguageScreen()),
    GetPage(name: myAccountScreen, page: () => const MyAccountScreen()),
    GetPage(name: pendingViewScreen, page: () => PendingViewScreen()),
    GetPage(name: acceptedViewScreen, page: () => AcceptedViewScreen()),
    GetPage(name: rejectedViewScreen, page: () => RejectedViewScreen()),
    GetPage(name: termScreen, page: () => TermScreen()),
    GetPage(name: reservationScreen, page: () => PendingReservationScreen()),
    GetPage(
        name: accptedReservationScreen, page: () => AccptedReservationScreen()),
    GetPage(
        name: rejectedReservationScreen,
        page: () => RejectedReservationScreen()),
    GetPage(
        name: rejectOrderScreen,
        page: () => RejectOrderScreen(),
        transition: Transition.downToUp),
  ];
}
