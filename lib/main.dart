import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:resto_page/constant/app_color.dart';
import 'package:resto_page/firebase_options.dart';
import 'package:resto_page/utils/app_routes.dart';
import 'package:resto_page/utils/app_translations.dart';
import 'package:resto_page/utils/push_notification_utils.dart';
import 'package:resto_page/utils/shared_prefs.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check if a Firebase app has already been initialized in this isolate
  if (Firebase.apps.isEmpty) {
    try {
      await Firebase.initializeApp(name: "devproject",
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      print('Error initializing Firebase in background handler: $e');
      if (!e.toString().contains('duplicate-app')) {
        rethrow;
      }
    }
  }
  
  await preferences.init();
  if (message != null) {
    print('Notification Arrived');
    await  NotificationUtils().showNotification(message: message, initializeNotification: true);
  }
}


  @pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Check if a Firebase app has already been initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(name: "devproject",
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Background handler for Firebase Messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await preferences.init();
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      title: 'Resto Page',
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      transitionDuration: Duration(milliseconds: 400),
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        primarySwatch: appPrimarySwatchColor,
        useMaterial3: true,
      ),
      initialRoute: Routes.splashScreen,
      getPages: Routes.routes,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(0.9)),
          child: child!,
        );
      },
    );
  }
}

// asia@restopage.eu
// #Q4*8T2B1u2V

// billy@made4you.lu
// p2b486cm886

// primo@topresto.lu
// p2b486cm886
