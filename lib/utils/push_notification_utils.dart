import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:resto_page/main.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto_page/api/repo/auth_repo.dart';
import 'package:resto_page/controllers/home_screen_controller.dart';
import 'package:resto_page/utils/shared_prefs.dart';

import 'app_routes.dart';

const String channelId = "unique_resto_page_channel_id";
const String channelName = "resto_page_app";
const String channelDes = "resto_page_channel_des";
List<String> checkRepetaion=[];
class NotificationUtils {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  void requestAndFetchAPNSToken() async {
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      // Request notification permissions
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Check if permission is granted before attempting to get the APNs token
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        String? apnsToken = await messaging.getAPNSToken();
        print("APNS Token: $apnsToken");

        if (apnsToken == null) {
          print("Failed to retrieve APNS token. Check APNs configuration.");
        }
      } else {
        print("Notification permissions not granted.");
      }
    }
  }

  Future<void> init(fromSplash) async {
    // bool? isBatteryOptimizationDisabled =
    //     await DisableBatteryOptimization.isBatteryOptimizationDisabled;
    // print(
    //     "Battery optimization is ${!isBatteryOptimizationDisabled! ? "Enabled" : "Disabled"}");
    // if (!isBatteryOptimizationDisabled!) {
    //   DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    // }
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    if (Platform.isAndroid) {
      if (Platform.isAndroid) {
        var androidImplementation = flutterLocalNotificationsPlugin
            ?.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        if (androidImplementation != null) {
          await androidImplementation.createNotificationChannel(channel);
        } else {
          print("AndroidFlutterLocalNotificationsPlugin is null.");
        }
      }
    } else {
      // flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //         IOSFlutterLocalNotificationsPlugin>()
      //     ?.requestPermissions(
      //       alert: true,
      //       sound: true,
      //     )
      //     .then((value) {
      //   if (value ?? false) {}
      // });
    }
       final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentSound: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const androidSettings =
        AndroidInitializationSettings("@drawable/ic_notification",);
    final settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin!.initialize(
      settings,
      onDidReceiveNotificationResponse: selectNotification,
      onDidReceiveBackgroundNotificationResponse:notificationTapBackground
    );

    notificationConfig(fromSplash);
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    channelId,
    channelName,
    description: channelDes,
    sound: RawResourceAndroidNotificationSound("notification_sound"),
    importance: Importance.max,
  );
  // flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  void notificationConfig(fromSplash) async {
    final _firebaseMessaging = await FirebaseMessaging.instance;
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      requestAndFetchAPNSToken();
      _firebaseMessaging.getToken().then((token) async {
        if (preferences.getBool(SharedPreference.IS_LOGGED_IN) ?? false) {
          print("TOKEN ========================================== $token");
          if (token != null) {
            preferences.putString('deviceToken', token);
            
          }

          await UserAuthRepo.updateDeviceToken(token!).then((v) {
            print('going to home screen');
            Get.offAllNamed(Routes.homeScreen);
          });

          // var data = await UserStartupRepo.instance.updatePushToken(
          //     devicePushToken: token!, userTimeZoneOffset: userTimeZoneOffset);
          if (kDebugMode) {}
        }
      }).catchError((e) {
        print('Something went wrong : $e');
      });
    } else {
      if (!fromSplash) {
        _showEnableNotificationsDialog();
        if (kDebugMode) {
          print('User declined or has not accepted permission');
        }
      }
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    onMessage();
  }

  // void onMessage() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Received a message while in the foreground!');
  //     print('Message data: ${message.data}');
  //     showNotification(initializeNotification: true, message: message);
  //   });
  // }

  void _showEnableNotificationsDialog() {
    // Show the dialog prompting the user to enable notifications
    Get.defaultDialog(
      title: "Enable Notifications",
      middleText:
          "Stay updated! Enable notifications to never miss important updates.",
      onConfirm: () {
        // Open the app settings screen to enable notifications
        AppSettings.openAppSettings(type: AppSettingsType.notification)
            .then((_) async {
          // After coming back from settings, check if notifications are enabled
          PermissionStatus status = await Permission.notification.status;

          if (status.isGranted) {
            // If notifications are granted, restart from the splash screen
            Get.offAllNamed(Routes.splashScreen);
          } else {
            // If not granted, navigate to the home screen or take other action
            Get.offAllNamed(Routes.homeScreen);
          }
        });
      },
      onCancel: () {
        // If the user cancels, navigate to the home screen
        Get.offAllNamed(Routes.homeScreen);
      },
    );
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');
      if(Platform.isIOS){
            showNotification(
      initializeNotification: false,
      message: message,
    );
      // checkRepetaion.add(message.data['body']['order_id']);
      }
      else{
      // Only show notification if it's a data message
      // if (message.notification != null) {
      // Firebase handles notification payloads; we display only data payloads
      //  NotificationUtils()
      //     .showNotification(initializeNotification: true, message: message);
       showNotification(
      initializeNotification: false,
      message: message,
    );
      }
    });
  }

  showNotification(
      {required RemoteMessage message, required bool initializeNotification}) async{
    if (initializeNotification) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    }

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentSound: false,
      // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const androidSettings =
        AndroidInitializationSettings("@drawable/ic_notification",);
    final settings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    flutterLocalNotificationsPlugin!.initialize(
      settings,
      onDidReceiveNotificationResponse: selectNotification,
      onDidReceiveBackgroundNotificationResponse:notificationTapBackground
    );
    print('show noti');
     final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin!.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    print(
        "App launched via local notification with payload: ${notificationAppLaunchDetails?.notificationResponse?.payload}");
    if (notificationAppLaunchDetails?.notificationResponse?.payload != null) {
      NotificationUtils().handlePushTap(
          jsonDecode(notificationAppLaunchDetails!.notificationResponse!.payload!));
    }
  }else{     "App launched via local)";}

        //testt
     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A notification was opened while the app was in the background!');

      if (message.data != null) {
        // Handle the tap on the notification with the data payload
        handlePushTap(message.data);
      }

      Map<String, dynamic> notification = {
        "title": message
            .notification?.title, // Handle safely with `?.` in case of null
        "description": message.notification?.body,
        "data": message.data.toString(),
      };

    });

    //testt
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDes,
        importance: Importance.max,
        icon: '@drawable/ic_notification',
        largeIcon: const DrawableResourceAndroidBitmap('ic_notification'),
        sound: const RawResourceAndroidNotificationSound("notification_sound"),
        color: const Color(0xFFED1C24),
        priority: Priority.high,
        playSound: true,
        timeoutAfter: 100000000,
        autoCancel: true,
        ongoing: true,
        onlyAlertOnce: false,
        audioAttributesUsage: AudioAttributesUsage.alarm,
        additionalFlags: Int32List.fromList(<int>[5])
        //  initializeNotification ? : null,
        );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      sound: 'notification_sound.aiff',
    );
    // periodic(iOSPlatformChannelSpecifics);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    String? tittle = "";
    String? body = "";
    Object? notification;
    if (message.notification != null) {
      print(message.notification!.title);
            print('message.notification!.title');
      notification = message.notification;
      tittle = message.notification!.title;
      body = message.notification!.body;
    } else {
      notification = message.data;
      tittle = message.data["title"];
      body = message.data["body"];
    }
    if (notification != null) {
      if (Platform.isIOS) {
        if (WidgetsBinding.instance.lifecycleState ==
            AppLifecycleState.resumed) {
          flutterLocalNotificationsPlugin!.show(
              notification.hashCode, tittle, body, platformChannelSpecifics,
              payload: jsonEncode(message.data));
        } else {
          print('background');
        }
      } else {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode, tittle, body, platformChannelSpecifics,
            payload: jsonEncode(message.data));
      }
    } else {
      if (Platform.isIOS) {
        if (WidgetsBinding.instance.lifecycleState ==
            AppLifecycleState.resumed) {
          flutterLocalNotificationsPlugin!.show(
              notification.hashCode, tittle, body, platformChannelSpecifics,
              payload: jsonEncode(message.data));
        } else {
          print('background');
        }
      } else {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode, tittle, body, platformChannelSpecifics,
            payload: jsonEncode(message.data));
      }
    }

     onMessageOpenApp();
  }



  void selectNotification(NotificationResponse? notificationResponse) async {
    if (notificationResponse != null && notificationResponse.payload != null) {
      try {
        print('selected one');
        print(notificationResponse.payload!);
        if (notificationResponse.payload!.isNotEmpty) {
          var response =
              json.decode(notificationResponse.payload!); // Safely decode JSON
          handlePushTap(response);
        } else {
          print("Payload is empty");
        }
      } catch (e) {
        if (kDebugMode) {
          print("JSON Parsing Exception: $e");
        }
      }
    } else {
      
      if (kDebugMode) {
        print("Notification payload is null or empty");
      }
    }
  }

  void onMessageOpenApp() {
    /// This function manages push notification tap when the app is in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print(
          'A notification was opened while the app was in the terminated state!');
// if (Platform.isIOS){
//   if(checkRepetaion.contains(message!.data['body']['order_id'])){
//     checkRepetaion.clear();
//   }
//   else{
//      if (message != null) { 
//     message.data['body']['order_id'];
//         // Handle the notification data
//         Map<String, dynamic> notification = {
//           "title": message
//               .notification?.title, // Handle safely with `?.` in case of null
//           "description": message.notification?.body,
//           "data": message.data.toString(),
//         };

//         print(
//           "Notification getInitialMessage :-  $notification",
//         );

//         // Handle the tap on the notification
//         handlePushTap(message.data);
//       } else -=-
//        print('refresh');
//         final homeScreenCtrl = Get.put(HomeScreenController());
//          Get.offAllNamed(Routes.homeScreenRefresh);

//       }
//   }
// }else{
    if (message != null) { 

        // Handle the notification data
        Map<String, dynamic> notification = {
          "title": message
              .notification?.title, // Handle safely with `?.` in case of null
          "description": message.notification?.body,
          "data": message.data.toString(),
        };

        print(
          "Notification getInitialMessage :-  $notification",
        );

        // Handle the tap on the notification
        handlePushTap(message.data);
      } else {
       print('refresh');
     try {
        if (!Get.isRegistered<HomeScreenController>()) {
          Get.put(HomeScreenController()); // Put if not already available
        }
        final homeScreenCtrl = Get.find<HomeScreenController>();
        // homeScreenCtrl.getViewAll();
        // Optional: Navigate after ensuring the controller is ready
        Get.offAllNamed(Routes.homeScreenRefresh);
      } catch (e) {
        print('Error while handling HomeScreenController: $e');
        // Optionally handle the error by showing an error message to the user or reattempting the initialization
      }
    

      }
// }
    
    });
    
    /// This function manages push notification tap when the app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A notification was opened while the app was in the background!');

      if (message.data != null) {
        // Handle the tap on the notification with the data payload
        handlePushTap(message.data);
      }

      Map<String, dynamic> notification = {
        "title": message
            .notification?.title, // Handle safely with `?.` in case of null
        "description": message.notification?.body,
        "data": message.data.toString(),
      };

      // printData(
      //     title: "Notification onMessageOpenedApp :-", val: notification.toString());
    });
  }

 
  handlePushTapWithPayload(String? payLoadData) {
    if (payLoadData != null) {
      log(payLoadData.toString(), name: "myapp call");
      try {
        Map<String, dynamic> payLoad = jsonDecode(payLoadData);

        if (payLoad["type"] != null) {
          switch (payLoad["type"]) {
            case "message":
              break;
            case "newQuestion":
              break;
            default:
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print("Notification Exception :-$e");
        }
      }
    }
  }

  handlePushTap(Map<String, dynamic>? payLoad) {
    if (payLoad != null) {
      // flutterLocalNotificationsPlugin!.cancel(0);

      try {print('nevigate');
      print(payLoad["dp_option"]);
        if (payLoad["dp_option"] == "reservation") {
          Get.offAllNamed(Routes.reservationScreen, arguments: {
            "id": payLoad["order_id"],
          });
        } else if (payLoad["dp_option"] == "delivery") {
          Get.offAllNamed(Routes.pendingViewScreen, arguments: {
            "id": payLoad["order_id"],
          });
        } else if (payLoad["dp_option"] == "pickup") {
          print('going to home screen handle');

          Get.offAllNamed(Routes.pendingViewScreen, arguments: {
            "id": payLoad["order_id"],
          });
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint("Notification Exception :-$e");
        }
      }
    }
   
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    if (payload != null) {
      handlePushTap(jsonDecode(payload));
      log(payload, name: "NOTIFICATION PAYLOAD");
    } else {
      if (kDebugMode) {
        print("PAYLOAD IS NULL");
      }
    }
  }
}
