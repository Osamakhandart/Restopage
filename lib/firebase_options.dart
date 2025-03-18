import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    projectId: 'restopage-47926',
    apiKey: 'AIzaSyB55COjdZM5xgvM1wQRT09lB_gKqnIiRAg',
    appId: '1:522951729770:android:250e40114395339cb02013',
    androidClientId:
        '1070334926818-5ofaaut2gmrspneslu464g9gkakgvdo3.apps.googleusercontent.com',
    messagingSenderId: '522951729770',
    storageBucket: 'restopage-47926.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2OUopp0b7qmr1F_pxKPLNYjvNnLnveqo',
    appId: '1:522951729770:ios:ff5cff2b5ec67e70b02013',
    messagingSenderId: '522951729770',
    projectId: 'restopage-47926',
    storageBucket: 'restopage-47926.appspot.com',
    // iosClientId:
    //     '1070334926818-5ofaaut2gmrspneslu464g9gkakgvdo3.apps.googleusercontent.com',
    iosBundleId: 'com.restopage',
  );
  // static const FirebaseOptions android = FirebaseOptions(
  //   projectId: 'restopage-c2e64',
  //   apiKey: 'AIzaSyAVxLl_1je-evah2jcwCMBL7CQyxtKzcao',
  //   appId: '1:1070334926818:android:64307390bfcd68d79963bb',
  //   androidClientId:
  //       '1070334926818-5ofaaut2gmrspneslu464g9gkakgvdo3.apps.googleusercontent.com',
  //   messagingSenderId: '1070334926818',
  //   storageBucket: 'restopage-c2e64.appspot.com',
  // );
  //
  // static const FirebaseOptions ios = FirebaseOptions(
  //   apiKey: 'AIzaSyB2OUopp0b7qmr1F_pxKPLNYjvNnLnveqo',
  //   appId: '1:1070334926818:ios:10219ffdf4b561229963bb',
  //   messagingSenderId: '1070334926818',
  //   projectId: 'restopage-c2e64',
  //   storageBucket: 'restopage-c2e64.appspot.com',
  //   iosClientId:
  //       '1070334926818-5ofaaut2gmrspneslu464g9gkakgvdo3.apps.googleusercontent.com',
  //   iosBundleId: 'com.made4you.restoPage',
  // );
}
