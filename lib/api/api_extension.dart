import 'package:flutter/foundation.dart';

// import '../constant/requst_const.dart';

void printData({required dynamic tittle, dynamic val}) {
  if (kDebugMode) {
    print("$tittle:-$val");
  }
}

// Map<String, String> requestHeader() {
//   return {
//     RequestHeaderKey.bearerToken:
//         "Bearer {cOq-cAGoaVox2nSveyhMOsnvfdyq-t=uCSU}",
//   };
// }

String errorText = "Something went wrong";
String statusText = "Success";

Map<String, String> requestHeader() {
  return {
    "Content-Type": "application/json",
    'Cookie': 'ci_session=0175de1002b130e78352e16f610bcb080af9c437',
    "Content-Length": "57",
    "Host": "<calculated when request is sent>",
    "User-Agent": "PostmanRuntime/7.32.3",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    // if (passAuthToken)
    //   RequestHeaderKey.authToken:
    //       preference.getString(SharedPreference.AUTH_TOKEN_KEY) ?? '',
  };
}
