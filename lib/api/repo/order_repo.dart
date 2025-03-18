import 'package:resto_page/utils/shared_prefs.dart';

import '../../constant/request_constant.dart';
import '../../models/response_item.dart';
import '../api_helpers.dart';

class OrderRepo {
  static Future<ResponseItem> getOrderAndReservation() async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.getOrdersAndReservations +
        preferences.getString(SharedPreference.REST_ID)!;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }

  static Future<ResponseItem> getAllPending() async {
    ResponseItem result;

    dynamic params = {
      "limit": "20",
      "offset": "0",
      "status": "pending",
    };

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.getOrdersAndReservations +
        preferences.getString(SharedPreference.REST_ID)!;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> getAllAccepted() async {
    ResponseItem result;

    dynamic params = {
      "status": "accepted",
    };

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.getOrdersAndReservations +
        preferences.getString(SharedPreference.REST_ID)!;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> getAllRejected() async {
    ResponseItem result;

    dynamic params = {
      "limit": "20",
      "offset": "0",
      "status": "accepted",
    };

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.getOrdersAndReservations +
        preferences.getString(SharedPreference.REST_ID)!;

    result = await BaseApiHelper.uploadFormData(
        requestUrl: requestUrl, requestData: params);

    return result;
  }

  static Future<ResponseItem> getOpenTime() async {
    ResponseItem result;

    String requestUrl = AppUrls.BASE_URL +
        MethodNames.getOpenTime +
        preferences.getString(SharedPreference.REST_ID)!;

    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }
}
