import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resto_page/theme/app_layout.dart';

import '../models/response_item.dart';
import 'api_exception.dart';

class BaseApiHelper {
  static Future<ResponseItem> postRequest(
      String requestUrl, Map<String, dynamic> requestData) async {

    return await http
        .post(
          Uri.parse(requestUrl),
          // body: requestData,
          body: json.encode(requestData),

          // encoding: Encoding.getByName('utf-8'),
          // headers: requestHeader()
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<dynamic> getRequest(String requestUrl,
      {Map<String, dynamic>? params}) async {

    // log("headers:${requestHeader(passAuthToken)}");

    return await http
        .get(
          Uri.parse(requestUrl),
          // headers: requestHeader(passAuthToken)
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) {

      return onError(error);
    });
  }

  static Future<ResponseItem> deleteRequest(
      String requestUrl, bool passAuthToken) async {

    // log("headers:${requestHeader(passAuthToken)}");

    return await http
        .delete(
          Uri.parse(requestUrl),
          // headers: requestHeader(passAuthToken)
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> patchRequest(String requestUrl,
      Map<String, dynamic> requestData, bool passAuthToken) async {
    log("request:$requestUrl");
    // log("headers:${requestHeader(passAuthToken)}");

    return await http
        .patch(
          Uri.parse(requestUrl), body: json.encode(requestData),
          // headers: requestHeader(passAuthToken)
        )
        .then((response) => onValue(response))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> uploadFormData(
      {required String requestUrl,
      required Map<String, String> requestData}) async {
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));

    // request.headers.addAll(requestHeader(true));
    request.fields.addAll(requestData);

    log(request.toString(), name: "REQUEST");
    // log(profileImage!.field.toString());
    // log("body:${json.encode(requestData)}");
    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => onValue(value));
    }).onError((error, stackTrace) => onError(error));
  }

  static Future uploadStatus(
      {required String requestUrl,
      required Map<String, String> requestData}) async {
    var request = http.MultipartRequest("POST", Uri.parse(requestUrl));

    // request.headers.addAll(requestHeader(true));
    request.fields.addAll(requestData);


    // log(profileImage!.field.toString());
    // log("body:${json.encode(requestData)}");
    return await request.send().then((streamedResponse) {
      return http.Response.fromStream(streamedResponse)
          .then((value) => uploadOnStatus(value));
    });
  }

  static Future uploadOnStatus(http.Response response) async {

    if (response.statusCode == 200 || response.statusCode == 201) {
  
    } else {}
  }

  String base64Decode(String encoded) {
    return utf8.decode(base64.decode(encoded));
  }

  static Future onValue(http.Response response) async {
 

    final ResponseItem result =
        ResponseItem(status: false, message: "Something went wrong.");

    dynamic data = json.decode(response.body);
   
    if (response.statusCode == 200 || response.statusCode == 201) {
      result.status = true;
      result.data = data;
      log("Success");
    } else if (response.statusCode == 400) {
      result.message = data["msg"] ?? "";
    
      showAppSnackBar("Invalid Status");
      Get.back();
    } else {
      result.message = data["msg"] ?? "";
   
    }

    return result;
  }

  // static Future baseOnValue(http.Response response) async {
  //   ResponseItem result;
  //   final Map<String, dynamic> responseData = json.decode(response.body);
  //   String status;
  //   String message;
  //   dynamic data = responseData;
  //
  //   log("responseCode: ${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     message = "Ok";
  //     status = "Success";
  //     data = responseData;
  //   } else {
  //     log("response: $data", name: 'error');
  //     message = "Something went wrong.";
  //   }
  //   result = ResponseItem(data: data, message: message, status: status);
  //   log("response: {data: ${result.data}, message: $message, status: $status}",
  //       name: APP_NAME);
  //   return result;
  // }

  static onError(error) {
    log("Error caused: $error");
    String message = "Unsuccessful request";
    if (error is SocketException) {
      message = ResponseException("No internet connection").toString();
    } else if (error is FormatException) {
      // message = ResponseException("Something wrong in response.").toString() +
      //     error.toString();
    }
    return ResponseItem(data: null, message: message, status: false);
  }
}
